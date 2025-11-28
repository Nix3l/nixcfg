import Quickshell
import QtQuick

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components"

BarItem {
    id: root;

    hovered: () => { GlobalState.drawers.dashboard = true; }

    StyledText {
        text: Time.format("ddd") + " " + Time.format(Config.clock.fmt12Hour ? "hh:mm ap" : "hh:mm");
    }
}
