import Quickshell
import QtQuick
import QtQuick.Controls.Basic

import "root:/cfg"
import "root:/style"

Slider {
    id: root;

    required property var getPosition;
    required property var setPosition;

    value: getPosition();

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: root.availableWidth
        height: implicitHeight
        radius: 2
        color: Style.colors.bg1;

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: Style.colors.fg;
        }
    }

    handle: null;

    Timer {
        running: root.visible;
        repeat: true;
        interval: 800;
        onTriggered: {
            root.value = root.getPosition();
            root.moved();
        }
    }

    onMoved: if(root.pressed) setPosition(value);
}

