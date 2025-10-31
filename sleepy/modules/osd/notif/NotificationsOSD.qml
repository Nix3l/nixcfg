import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/services/notifs"

PanelWindow {
    id: root;
    WlrLayershell.layer: WlrLayer.Top;
    exclusiveZone: 0;

    readonly property list<TimedNotif> notifs: Notifs.notifs.filter(n => n.display);

    anchors {
        top: true;
        bottom: true;
    }

    implicitWidth: Config.notifs.width;
    color: "transparent";

    // NOTE(nix3l): so this would technically make the gaps between notifications also part of the mask
    // but i highly doubt i would really notice so
    // keeping it like this for now
    mask: Region {
        item: content;
    }

    ColumnLayout {
        id: content;
        spacing: Style.spacing.large;
        y: Config.notifs.margin;

        Repeater {
            id: repeater;
            model: root.notifs;

            NotifItem {
                id: notif;
                leftClicked: () => { notif.modelData.display = false; }
            }
        }
    }
}
