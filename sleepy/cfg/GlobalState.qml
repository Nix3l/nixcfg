pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root;

    property bool applauncherOpen: false;
    property bool mediaDrawerOpen: false;
    property bool notifDrawerOpen: false;
    property bool bluetoothDrawerOpen: false;
    property bool dashboardDrawerOpen: false;
}
