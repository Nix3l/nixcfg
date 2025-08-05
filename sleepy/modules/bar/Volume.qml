import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/services"
import "root:/style"

BarItem {
    id: root;

    readonly property string text: {
        return Math.floor((Audio.vol() * 100)) + "%";
    }

    readonly property string icon: {
        if(Audio.vol() < 0.50) return "";
        if(Audio.vol() < 0.75) return "";
        return "";
    }

    Text {
        text: root.icon;
        color: Audio.muted() ? Style.colors.fgMuted : Style.colors.fg;
    }

    Text {
        text: root.text;
        color: Audio.muted() ? Style.colors.fgMuted : Style.colors.fg;
    }
}
