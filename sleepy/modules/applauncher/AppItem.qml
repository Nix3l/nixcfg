import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components"
import "root:/components/chooser"

ChooserItem {
    id: root;

    activate: () => {
        Apps.run(root.modelData);
        root.chooser.close();
    }

    leftClicked: () => {
        activate();
    }

    RowLayout {
        anchors {
            left: parent.left;
            verticalCenter: parent.verticalCenter;
            margins: Config.chooser.itemPadding;
        }

        spacing: Style.spacing.normal;

        IconImage {
            Layout.alignment: Qt.AlignLeft;
            visible: Config.applauncher.showIcons;
            source: Quickshell.iconPath(modelData.icon ?? "");
            implicitSize: Config.chooser.contentHeight * 0.77;
            mipmap: true;
        }

        StyledText {
            Layout.alignment: Qt.AlignLeft;
            text: modelData?.name;
            color: selected ? Style.colors.bg0 : Style.colors.fg1;
            font.pointSize: Config.chooser.itemFontSize;
        }
    }
}
