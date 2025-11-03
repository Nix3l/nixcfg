import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/services"
import "root:/style"
import "root:/components"

BarItem {
    borderColor: Style.colors.fg0;

    StyledIcon {
        visible: Network.enabled;
        source: Icons.wifiStrengthIcon(Network.strength);
        implicitSize: Style.icons.small;
    }

    StyledText {
        visible: Network.enabled;
        text: Network.ssid;
        color: Style.colors.fg1;
    }

    StyledIcon {
        visible: !Network.enabled;
        source: Icons.wifi.off;
        implicitSize: Style.icons.small;
    }

    StyledText {
        visible: !Network.enabled;
        text: "Disconnected";
    }
}
