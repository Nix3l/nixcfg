import Quickshell
import QtQuick

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components"

BarItem {
    id: root;

    hovered: () => { GlobalState.dashboardDrawerOpen = true; };

    StyledText {
        text: Time.format("ddd hh:mm");
    }
}
