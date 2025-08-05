pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root;

    property list<Notification> notifs: [];
    property bool read: true;

    NotificationServer {
        id: server;
        persistenceSupported: true;
        keepOnReload: true;

        onNotification: notif => {
            notif.tracked = true;
            root.notifs.push(notif);
            root.read = false;
        }
    }
}
