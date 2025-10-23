import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/services"
import "root:/style"
import "root:/components"

BarItem {
    borderColor: Style.colors.fg0;

    IconImage {
        visible: Network.enabled;
        source: Icons.wifiStrengthIcon(Network.strength);
        mipmap: true;
        implicitSize: 14;
    }

    StyledText {
        visible: Network.enabled;
        text: Network.ssid;
        color: Style.colors.fg1;
    }

    IconImage {
        visible: !Network.enabled;
        source: Icons.wifi.off;
        mipmap: true;
        implicitSize: 14;
    }

    StyledText {
        visible: !Network.enabled;
        text: "Disconnected";
    }
}
