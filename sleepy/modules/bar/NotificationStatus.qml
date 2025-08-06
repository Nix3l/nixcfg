import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick

import "root:/services/notifs"
import "root:/style"

MouseArea {
    id: root;
    anchors.verticalCenter: parent.verticalCenter;
    anchors.top: parent.top;
    implicitWidth: content.implicitWidth;
    implicitHeight: content.implicitHeight;

    acceptedButtons: Qt.LeftButton;

    BarItem {
        id: content;

        IconImage {
            source: Notifs.read ? Icons.notifs.read : Icons.notifs.unread;
            mipmap: true;
            implicitSize: 16;
        }

        Text {
            visible: Notifs.notifs.length > 0;
            text: Notifs.notifs.length;
            color: Style.colors.fg;
        }
    }

    onPressed: Notifs.clear();
}
