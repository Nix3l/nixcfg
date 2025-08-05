import Quickshell
import QtQuick

import "root:/services"
import "root:/style"

BarItem {
    id: root;

    Text {
        text: Time.format("ddd hh:mm");
        color: Style.colors.fg;
    }
}
