import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/components"
import "root:/services"
import "root:/services/network"
import "root:/modules/drawers"

Item {
    id: root;

    property alias field: inputfield;

    property var cancel;
    property var accept;

    property color bgColor: Style.colors.bg0;
    property color borderColor: Style.colors.bg1;
    property color focusedBgColor: Style.colors.bg1;
    property color focusedBorderColor: Style.colors.fg0;

    property int borderSize: Style.border.thin;

    property color textColor: Style.colors.fg1;
    property color placeholderColor: Style.colors.fg0;

    property string placeholder: "";

    property int padding: Style.padding.normal;

    StyledBg {
        color: inputfield.focus ? root.focusedBgColor : root.bgColor;
        border.color: inputfield.focus ? root.focusedBorderColor : root.borderColor;
        border.width: root.borderSize;
    }

    function grabFocus(focus: bool) {
        inputfield.focus = focus;
    }

    Item {
        anchors.fill: parent;
        anchors.margins: root.padding;

        TextField {
            id: inputfield;
            anchors.fill: parent;

            color: root.textColor;
            font.pointSize: Style.text.small;
            font.family: Style.fonts.normal;

            placeholderText: root.placeholder;
            placeholderTextColor: root.placeholderColor;

            background: null;
            focus: true;
        }
    }
}
