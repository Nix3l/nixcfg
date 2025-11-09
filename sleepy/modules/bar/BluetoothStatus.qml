import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/cfg"
import "root:/components"
import "root:/style"
import "root:/services"

BarItem {
    visible: Config.modules.bluetoothStatus;

    hovered: () => { GlobalState.drawers.bluetooth = true; };

    StyledIcon {
        source: {
            if(!Bluetooth.enabled) return Icons.bluetooth.disabled;
            if(!Bluetooth.connected) return Icons.bluetooth.enabled;
            if(Bluetooth.connectedDevice?.icon != "") return Quickshell.iconPath(Bluetooth.connectedDevice?.icon);
            else return Icons.bluetooth.connected;
        }
    }

    StyledText {
        visible: Bluetooth.enabled && Bluetooth.connected;
        text: Bluetooth.connectedDevice?.name ?? "";

        color: Style.colors.fg1;
    }
}
