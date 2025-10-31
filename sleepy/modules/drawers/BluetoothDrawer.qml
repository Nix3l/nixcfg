import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/components"
import "root:/services"

BaseDrawer {
    id: root;

    isVisible: () => GlobalState.bluetoothDrawerOpen;
    toggle: (on) => { GlobalState.bluetoothDrawerOpen = on }

    property int padding: 8;

    implicitWidth: 320 + padding * 2;
    implicitHeight: 400 + header.implicitHeight + padding * 2;
}
