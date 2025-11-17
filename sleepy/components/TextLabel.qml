import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "root:/style"
import "root:/cfg"
import "root:/components"


RowLayout {
    required property string label;
    property string text: "";

    StyledText {
        text: parent.label;
        font.pointSize: Style.text.small;
    }

    StyledText {
        visible: parent.text != "";
        text: parent.text;
        color: Style.colors.fg0;
        font.pointSize: Style.text.small;
    }
}
