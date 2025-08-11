import Quickshell
import Quickshell.Widgets
import QtQuick

IconImage {
    id: root;

    mipmap: true;

    property var clicked;
    property bool enable: true;

    // TODO: change cursor on hover

    MouseArea {
        anchors.fill: parent;
        acceptedButtons: Qt.LeftButton;
        enabled: root.enable;
        onClicked: root.clicked();
    }
}
