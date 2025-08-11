import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/services"
import "root:/style"

BarItem {
    id: root;

    Text {
        text: Icons.volTextIcon(Audio.volume());
        color: Audio.muted() ? Style.colors.fgMuted : Style.colors.fg;
    }

    Text {
        text: Math.floor((Audio.volume() * 100)) + "%";
        color: Audio.muted() ? Style.colors.fgMuted : Style.colors.fg;
    }
}
