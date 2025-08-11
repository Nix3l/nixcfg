import Quickshell
import Quickshell.Widgets
import QtQuick

Item {
    id: root;

    property int border;
    property color borderColor;
    property string source;
    property int iconSize;

    implicitWidth: iconBorder.width;
    implicitHeight: iconBorder.height;

    Rectangle {
        id: iconBorder;
        width: icon.implicitSize + root.border;
        height: icon.implicitSize + root.border;
        color: root.borderColor;
    }

    IconImage {
        id: icon;
        anchors.centerIn: iconBorder;
        source: root.source;
        implicitSize: root.iconSize;
    }
}
