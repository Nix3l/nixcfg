pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "root:/cfg"

Singleton {
    id: root;

    property real brightness: 0;
    property real maxBrightness: 0;

    Process {
        running: true;
        command: [ "sh", "-c", "brightnessctl -c \"backlight\" i | head -3 | tail -1 | awk '{print $3}'" ];
        stdout: StdioCollector {
            onStreamFinished: root.maxBrightness = parseInt(this.text);
        }
    }

    Process {
        id: brightnessDetectionProc;
        running: true;
        command: [ "sh", "-c", "brightnessctl -c \"backlight\" g" ];
        stdout: StdioCollector {
            onStreamFinished: root.brightness = parseInt(this.text);
        }
    }

    Timer {
        running: true;
        repeat: true;
        interval: Config.timing.brightnessUpdate;
        onTriggered: brightnessDetectionProc.running = true;
    }

    function setBrightness(val: real) {
        if(val > root.maxBrightness) val = root.maxBrightness;
        root.brightness = val;

        Quickshell.execDetached([
            "sh",
            "-c",
            `brightnessctl -c \"backlight\" s ${val}`
        ]);
    }
}
