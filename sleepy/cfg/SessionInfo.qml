pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root;

    property string terminal: "";
    property string browser: "";
    property string explorer: "";
    property string user: "";
    property string machine: "";

    Process {
        running: true;
        command: [ "sh", "-c", "echo $TERMINAL,$BROWSER,$EXPLORER,$USER,$HOST" ];
        stdout: StdioCollector {
            onStreamFinished: {
                const info = this.text.split(",");
                terminal = info[0];
                browser = info[1];
                explorer = info[2];
                user = info[3];
                machine = info[4];
            }
        }
    }
}
