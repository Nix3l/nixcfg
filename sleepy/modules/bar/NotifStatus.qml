import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick

import "root:/cfg"
import "root:/services/notifs"
import "root:/style"

BarItem {
    id: content;

    hovered: () => {
        Notifs.readNotifs();
        GlobalState.notifDrawerOpen = true;
    };

    IconImage {
        source: Notifs.read ? Icons.notifs.read : Icons.notifs.unread;
        mipmap: true;
        implicitSize: 16;
    }

    Text {
        visible: Notifs.notifsSinceLastRead > 0;
        text: Notifs.notifsSinceLastRead;
        color: Style.colors.fg;
    }
}
