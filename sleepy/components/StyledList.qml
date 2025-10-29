pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/services/notifs"
import "root:/modules/osd/notif"
import "root:/components"

ClippingRectangle {
    id: root;
    color: 'transparent';

    property alias items: listviewItem;
    property int spacing: 8;

    implicitHeight: listviewItem.implicitHeight;

    ListView {
        id: listviewItem;
        anchors.fill: parent;
        orientation: Qt.Vertical;
        spacing: root.spacing;
        boundsBehavior: Flickable.StopAtBounds;
        flickDeceleration: 10;
    }
}
