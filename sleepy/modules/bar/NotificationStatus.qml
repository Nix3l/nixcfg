import Quickshell
import Quickshell.Widgets;
import Quickshell.Services.Notifications;
import QtQuick

import "root:/services"
import "root:/style"

BarItem {
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
