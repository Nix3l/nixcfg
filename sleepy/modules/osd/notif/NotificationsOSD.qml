import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/services/notifs"

PanelWindow {
    id: root;
    WlrLayershell.layer: WlrLayer.Top;
    exclusiveZone: 0;

    anchors {
        top: true;
        bottom: true;
    }

    implicitWidth: Config.notifs.width;
    color: 'transparent';

    mask: Region {}

    ColumnLayout {
        id: content;
        spacing: 12;
        y: Config.notifs.margin;

        Repeater {
            id: notifrepeater;
            model: Notifs.notifs.filter(n => n.display);

            NotifItem {}
        }
    }
}
