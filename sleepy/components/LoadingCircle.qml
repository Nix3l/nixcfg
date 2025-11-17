pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "root:/style"
import "root:/cfg"
import "root:/services"

Item {
    id: root;

    // rotations per second
    property real speed: 0.9;
    // angle change per trigger
    property real step: 2;

    property real angle: 0;

    implicitWidth: icon.implicitSize;
    implicitHeight: icon.implicitSize;

    Timer {
        running: true;
        repeat: true;
        interval: (1000 * step) / (360 * speed);
        onTriggered: angle += step;
    }

    transform: Rotation {
        origin.x: icon.implicitSize / 2;
        origin.y: icon.implicitSize / 2;
        angle: root.angle;
    }

    StyledIcon {
        id: icon;
        anchors.centerIn: parent;
        source: Icons.other.loading;
    }
}
