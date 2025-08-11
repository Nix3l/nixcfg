pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "root:/cfg"

Singleton {
    id: root;

    property real brightness: 0;

    Process {
        id: brightnessDetectionProc;
        running: true;
        command: [ "sh", "-c", "" ];
        stdout: StdioCollector {
            onStreamFinished: {
                
            }
        }
    }

    Timer {
        running: true;
        repeat: true;
        interval: Config.timing.brightnessUpdate;
        onTriggered: brightnessDetectionProc.running = true;
    }
}
