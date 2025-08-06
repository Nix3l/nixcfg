pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

import "root:/cfg"

Singleton {
    id: root;

    Component {
        id: timedNotifComp;
        TimedNotif {}
    }

    property list<TimedNotif> notifs: [];
    property bool read: true;

    NotificationServer {
        id: server;
        persistenceSupported: true;
        keepOnReload: false;

        onNotification: notif => {
            notif.tracked = true;
            root.read = false;
            root.notifs.push(timedNotifComp.createObject(root, {
                data: notif,
                displayTimeout: Config.timing.notifDisplayTimeout
            }));
        }
    }

    function clear() {
        for(const notif in notifs) notif.data?.dismiss();
        notifs = [];
        read = true;
    }

    function expireNotif(notif: TimedNotif) {
        notif.data.expire();
        notifs = notifs.filter(n => n !== notif);
    }

    function dismissNotif(notif: TimedNotif) {
        notif.data.dismiss();
        notifs = notifs.filter(n => n !== notif);
    }
}
