import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/services"
import "root:/style"

BarItem {
    IconImage {
        visible: Network.enabled;
        source: Icons.wifiStrengthIcon(Network.strength);
        mipmap: true;
        implicitSize: 14;
    }

    Text {
        visible: Network.enabled;
        text: Network.ssid;
        color: Style.colors.fg;
    }

    IconImage {
        visible: !Network.enabled;
        source: Icons.wifi.off;
        mipmap: true;
        implicitSize: 14;
    }

    Text {
        visible: !Network.enabled;
        text: "Disconnected";
        color: Style.colors.fg;
    }
}
