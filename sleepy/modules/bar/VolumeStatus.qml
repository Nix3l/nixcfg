import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/services"
import "root:/style"
import "root:/components"

BarItem {
    id: root;

    borderColor: Style.colors.fg0;

    StyledText {
        text: Icons.volTextIcon(Audio.volume());
        color: Audio.muted() ? Style.colors.fg0 : Style.colors.fg1;
    }

    StyledText {
        text: Math.round((Audio.volume() * 100)) + "%";
        color: Audio.muted() ? Style.colors.fg0 : Style.colors.fg1;
    }
}
