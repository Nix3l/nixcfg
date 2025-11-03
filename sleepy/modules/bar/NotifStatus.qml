import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick

import "root:/cfg"
import "root:/services/notifs"
import "root:/components"
import "root:/style"

BarItem {
    id: root;

    hovered: () => {
        Notifs.readNotifs();
        GlobalState.notifDrawerOpen = true;
    }

    StyledIcon {
        source: Notifs.read ? Icons.notifs.read : Icons.notifs.unread;
        implicitSize: Style.icons.normal;
    }

    StyledText {
        visible: Notifs.notifsSinceLastRead > 0;
        text: Notifs.notifsSinceLastRead;
        color: Style.colors.fg1;
    }
}
