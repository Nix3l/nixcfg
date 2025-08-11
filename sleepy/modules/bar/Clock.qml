import Quickshell
import QtQuick

import "root:/cfg"
import "root:/style"
import "root:/services"

BarItem {
    id: root;

    hovered: () => { GlobalState.dashboardDrawerOpen = true; };

    Text {
        text: Time.format("ddd hh:mm");
        color: Style.colors.fg;
    }
}
