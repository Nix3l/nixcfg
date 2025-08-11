import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components"

Item {
    id: root;

    property int padding: 10;
    property color bg: Style.colors.bg0;
    property int border: 1;
    property color borderCol: Style.colors.bg1;

    property int spacing: 2;

    required property var getPosition;
    required property var setPosition;
    property int sliderHeight: 6;
    property int sliderRadius: 2;
    property color sliderBg: Style.colors.bg1;
    property color sliderHighlight: Style.colors.fg;
    property bool onTimer: true;

    property string icon: "";
    property int iconSize: 0;
    property var iconLeftClicked;

    property bool showPercentage: true;
    property int textSize: 16;

    Rectangle {
        anchors.fill: parent;
        color: root.bg;
        border {
            width: root.border;
            color: root.borderCol;
        }
    }

    RowLayout {
        anchors.fill: parent;
        anchors.margins: root.padding;
        spacing: root.spacing;

        Item {
            Layout.alignment: Qt.AlignLeft;

            implicitWidth: sliderIcon.implicitSize;
            implicitHeight: sliderIcon.implicitSize;

            IconImage {
                id: sliderIcon;
                visible: root.icon != "";
                anchors.centerIn: parent;
                source: root.icon;
                implicitSize: root.iconSize;
                mipmap: true;
            }

            MouseArea {
                anchors.fill: sliderIcon;
                acceptedButtons: Qt.LeftButton;
                onPressed: if(root.iconLeftClicked != undefined) root.iconLeftClicked();
            }
        }

        CustomSlider {
            id: slider;
            Layout.fillWidth: true;

            radius: root.sliderRadius;
            sliderHeight: root.sliderHeight;

            bg: root.sliderBg;
            highlight: root.sliderHighlight;

            onTimer: root.onTimer;

            getPosition: root.getPosition;
            setPosition: root.setPosition;
        }

        Text {
            visible: root.showPercentage;
            Layout.alignment: Qt.AlignRight;
            text: Math.floor(root.getPosition() * 100) + "%";
            color: Style.colors.fg;
            font.pixelSize: root.textSize;
        }
    }
}
