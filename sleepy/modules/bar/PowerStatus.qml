import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/cfg"
import "root:/components"
import "root:/services"
import "root:/style"

BarItem {
    id: root;
    visible: Config.modules.powerStatus;

    StyledIcon {
        source: {
            if(Power.icon != "") return Quickshell.iconPath(Power.icon);
            if(Power.charging) return Icons.power.battery_charging;
            return Icons.batteryIcon(Power.percentage);
        }
    }

    StyledText {
        text: Math.floor(Power.percentage * 100) + "%";
    }
}
