import Quickshell
import QtQuick
import QtQuick.Controls.Basic

import "root:/cfg"
import "root:/style"

Slider {
    id: root;

    required property var getPosition;
    required property var setPosition;

    property int radius: 2;
    property int sliderHeight: 4;

    property color bg: Style.colors.bg1;
    property color highlight: Style.colors.fg;

    property bool onTimer: true;

    value: getPosition();

    snapMode: Slider.SnapAlways;

    background: Rectangle {
        x: root.leftPadding;
        y: root.topPadding + (root.availableHeight - height) / 2;
        implicitHeight: root.sliderHeight;
        width: root.availableWidth;
        height: implicitHeight;
        radius: root.radius;
        color: root.bg;

        Rectangle {
            width: root.visualPosition * parent.width;
            height: parent.height;
            radius: root.radius;
            color: root.highlight;
        }
    }

    handle: null;

    Timer {
        running: root.visible && root.onTimer;
        repeat: true;
        interval: 800;
        onTriggered: {
            root.value = root.getPosition();
            root.moved();
        }
    }

    onMoved: if(root.pressed) setPosition(value);
}

