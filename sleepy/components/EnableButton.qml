pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/services"

Item {
    id: root;

    property var clicked;

    property bool enabled;

    property int bulbRadius: 6;
    property int sliderWidth: 24;
    property int sliderHeight: 8;

    property color bulbColor: Style.colors.fg1;
    property color enabledColor: Style.colors.alt1;
    property color disabledColor: Style.colors.fg0;
    property color borderColor: Style.colors.bg1;
    property int borderSize: Style.border.thin;

    property int rounding: Style.rounding.normal;

    implicitWidth: sliderWidth;
    implicitHeight: bulbRadius * 2;

    // man i love qml
    onEnabledChanged: {
        bulb.x = enabled ? implicitWidth - bulbRadius * 2 : 0;
    }

    Rectangle {
        id: bulb;
        z: 1;
        implicitWidth: root.bulbRadius * 2;
        implicitHeight: root.bulbRadius * 2;
        radius: root.bulbRadius;
        color: root.bulbColor;
    }

    Rectangle {
        id: enabledArea;
        anchors.left: root.left;
        anchors.right: bulb.horizontalCenter;
        anchors.verticalCenter: bulb.verticalCenter;
        implicitHeight: root.sliderHeight;
        color: root.enabledColor;
        topLeftRadius: root.rounding;
        bottomLeftRadius: root.rounding;
        border.width: root.borderSize;
        border.color: root.borderColor;
    }

    Rectangle {
        id: disabledArea;
        anchors.right: root.right;
        anchors.left: bulb.horizontalCenter;
        anchors.verticalCenter: bulb.verticalCenter;
        implicitHeight: root.sliderHeight;
        color: root.disabledColor;
        topRightRadius: root.rounding;
        bottomRightRadius: root.rounding;
        border.width: root.borderSize;
        border.color: root.borderColor;
    }

    MouseArea {
        anchors.fill: parent;
        acceptedButtons: Qt.LeftButton;
        onClicked: () => { 
            root.enabled = !root.enabled;
            if(root.clicked != undefined) root.clicked();
        }
    }
}
