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

    property int hpadding: Style.padding.normal;
    property color bg: Style.colors.bg0;
    property int border: Style.border.thin;
    property color borderCol: Style.colors.bg1;

    property int spacing: Style.spacing.smallest;

    required property var getPosition;
    required property var setPosition;
    property real sliderStepSize: 0.0;
    property int sliderHeight: 6;
    property int sliderRadius: Style.rounding.normal;
    property color sliderBg: Style.colors.bg1;
    property color sliderHighlight: Style.colors.fg1;
    property bool onTimer: false;

    property string icon: "";
    property int iconSize: 0;
    property var iconLeftClicked;

    property bool showPercentage: true;

    StyledBg {
        color: root.bg;
        border.width: root.border;
        border.color: root.borderCol;
    }

    RowLayout {
        anchors.fill: parent;
        anchors.leftMargin: root.hpadding;
        anchors.rightMargin: root.hpadding;
        spacing: root.spacing;

        Item {
            visible: root.icon != "";
            Layout.alignment: Qt.AlignLeft;

            implicitWidth: sliderIcon.implicitSize;
            implicitHeight: sliderIcon.implicitSize;

            IconImage {
                id: sliderIcon;
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

            stepSize: root.sliderStepSize;

            radius: root.sliderRadius;
            sliderHeight: root.sliderHeight;

            bg: root.sliderBg;
            highlight: root.sliderHighlight;

            onTimer: root.onTimer;

            getPosition: root.getPosition;
            setPosition: root.setPosition;
        }

        Item {
            visible: root.showPercentage;
            Layout.alignment: Qt.AlignRight;
            // pad it a bit to make the spacing more regular
            implicitWidth: root.iconSize + root.spacing * 2;
            StyledText {
                anchors.right: parent.right;
                anchors.verticalCenter: parent.verticalCenter;
                text: Math.round(root.getPosition() * 100) + "%";
                font.pointSize: Style.text.normal;
            }
        }
    }
}
