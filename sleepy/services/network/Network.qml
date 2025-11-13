pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "root:/cfg"

Singleton {
    id: root;

    property bool wifiEnabled: false;
    property bool ethernetEnabled: false;
    readonly property bool enabled: wifiEnabled || ethernetEnabled;

    Component {
        id: wifiNetworkComponent;
        WifiNetwork {}
    }

    property list<WifiNetwork> wifiNetworks: [];
    property WifiNetwork connectedWifi: null;

    property list<string> bonds: [];

    function findWifiNetwork(ssid: string): WifiNetwork {
        let found = null;
        wifiNetworks.forEach((n) => { if(n.ssid == ssid) found = n; });
        return found;
    }

    function activeSSID(): string {
        return root.wifiEnabled ? root.connectedWifi?.ssid ?? "Disconnected" : "Ethernet";
    }

    function activeStrength(): int {
        return root.wifiEnabled ? root.connectedWifi?.strength ?? 0 : 100;
    }

    Process {
        id: connectProc;
        // TODO
    }

    function connect(network: WifiNetwork) {
        // TODO
    }

    function disconnect(network: WifiNetwork) {
        // TODO
    }

    function forget(network: WifiNetwork) {
        // TODO
    }

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
                    return;
                }

                if(info[1].includes("wireless")) root.wifiEnabled = true;
                else if(info[1].includes("ethernet")) root.ethernetEnabled = true;
            }
        }
    }

    Process {
        id: bondsUpdateProc;
        running: true;
        command: [ "sh", "-c", "nmcli -t -f NAME con show" ];
        stdout: StdioCollector {
            onStreamFinished: root.bonds = this.text.trim().split("\n");
        }
    }

    readonly property string wifiInfoFmt: "SSID,RATE,BANDWIDTH,SIGNAL,SECURITY,IN-USE";
    function parseWifiNetworkInfo(info: list<string>): WifiNetwork {
        const ssid      = info[0];
        const rate      = info[1];
        const bandwidth = info[2];
        const strength  = info[3];
        const security  = info[4];
        const connected = info[5].includes("*");

        return wifiNetworkComponent.createObject(root, {
            ssid: ssid,
            rate: rate,
            bandwidth: bandwidth,
            strength: strength,
            security: security,
            connected: connected,
            bonded: root.bonds.includes(ssid),
        });
    }

    Process {
        id: wifiUpdateProc;
        running: true;

        command: [
            "sh",
            "-c",
            "nmcli -t -f " + wifiInfoFmt + " device wifi"
        ];

        stdout: StdioCollector {
            onStreamFinished: {
                const networkInfo = []; // 2d array of strings in wifiInfoFmt format
                this.text.trim().split("\n").forEach((n) => {
                    networkInfo.push(n.trim().split(":"));
                });

                const networks = []; // WifiNetwork objs
                networkInfo.forEach((n) => {
                    networks.push(parseWifiNetworkInfo(n));
                });

                networks.sort((a,b) => {
                    return b.strength - a.strength;
                });

                networks.forEach((n) => {
                    let pair = root.findWifiNetwork(n.ssid);
                    if(pair == null) {
                        root.wifiNetworks.push(n);
                    } else if(n.strength > pair.strength) {
                        pair.strength = n.strength;
                        pair.rate = n.rate;
                        pair.bandwidth = n.bandwidth;
                        pair.connected = n.connected ? true : pair.connected;
                    }
                });

                // TODO(nix3l): sorting?
                wifiNetworks.forEach((n) => {
                    if(n.connected) root.connectedWifi = n;
                    n.bonded = root.bonds.includes(n.ssid);
                });
            }
        }
    }

    Timer {
        interval: Config.timing.networkUpdate;
        running: true;
        repeat: true;
        onTriggered: {
            networkUpdateProc.running = true;
            wifiUpdateProc.running = root.wifiEnabled;
            bondsUpdateProc.running = true;
        }
    }
}
