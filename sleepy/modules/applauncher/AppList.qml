pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/services"

ClippingRectangle {
    id: root;

    required property TextField search;
    property list<DesktopEntry> applist: Apps.entries.filter(app => app.name.toLocaleLowerCase().includes(search.text.toLocaleLowerCase()));

    Layout.fillHeight: true;
    Layout.fillWidth: true;
    color: 'transparent';

    implicitHeight: listview.implicitHeight;

    ListView {
        id: listview;
        anchors.fill: parent;
        orientation: Qt.Vertical;
        spacing: Config.applauncher.spacing;

        implicitWidth: Config.applauncher.itemWidth;
        implicitHeight: (root.applist.length * Config.applauncher.itemHeight) - spacing;

        model: root.applist;
        delegate: AppItem {}

        keyNavigationEnabled: true;
        keyNavigationWraps: true;

        ScrollBar.vertical: ScrollBar {
            implicitWidth: 6;
        }

        focus: true;
    }
}
