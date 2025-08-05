import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/services"
import "root:/style"
import "root:/util"

BarItem {
    id: root;

    IconWithBorder {
        visible: Media.playerOpen;
        source: Media.active.trackArtUrl;
        iconSize: 16;
        border: 2;
        borderColor: Style.colors.accent;
    }

    Text {
        text: {
            if(Media.playerOpen) return Media.active.trackArtist + "・" + Media.active.trackTitle;
            else return "-- no active media --"
        }

        color: Style.colors.fg;
    }
}
