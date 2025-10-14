import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/cfg"
import "root:/services"
import "root:/style"

BarItem {
    id: root;
    visible: Config.modules.powerStatus;

    IconImage {
        source: {
            if(Power.icon != "") return Quickshell.iconPath(Power.icon);
            if(Power.charging) return Icons.power.battery_charging;
            return Icons.batteryIcon(Power.percentage);
        }

        implicitSize: 14;
        mipmap: true;
    }

    Text {
        text: Math.floor(Power.percentage * 100) + "%";
        color: Style.colors.fg;
    }
}
