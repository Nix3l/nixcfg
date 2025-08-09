pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "root:/cfg"

Singleton {
    id: root;

    // TODO: this stops working after a while

    property bool wifiEnabled: false;
    property bool ethernetEnabled: false;
    readonly property bool enabled: wifiEnabled || ethernetEnabled;
    property string ssid: "";
    property int strength: 0;

    Process {
        id: networkUpdateProc;
        running: true;

        command: [ "sh", "-c", "nmcli -t -f NAME,TYPE con show --active | head -1" ];

        stdout: StdioCollector {
            onStreamFinished: {
                const info = this.text.trim().split(":");

                if(info[0] === "lo") {
                    root.wifiEnabled = false;
                    root.ethernetEnabled = false;
                    root.ssid = "";
                    root.strength = 0;
                    return;
                }

                root.ssid = info[0];
                if(info[1].includes("wireless")) root.wifiEnabled = true;
                else if(info[1].includes("ethernet")) root.ethernetEnabled = true;

                if(root.ethernetEnabled) {
                    root.ssid = "Ethernet";
                    root.strength = 100;
                }
            }
        }
    }

    Process {
        id: signalStrengthUpdateProc;
        running: true;

        command: [ "sh", "-c", "nmcli -t -f IN-USE,SIGNAL device wifi" ];

        stdout: StdioCollector {
            onStreamFinished: {
                const info = this.text.trim().split(":");
                // stupid but works (i will never learn awk you cant make me)
                for(let i = 0; i < info.length; i ++) {
                    if(info[i] == "*") {
                        root.strength = info[i + 1];
                        return;
                    }
                }
            }
        }
    }

    Timer {
        interval: Config.timing.networkUpdate;
        running: true;
        repeat: true;
        onTriggered: {
            networkUpdateProc.running = true;
            signalStrengthUpdateProc.running = true;
        }
    }
}
