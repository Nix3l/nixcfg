import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components/chooser"

ChooserItem {
    id: root;

    leftClicked: () => {
        Apps.run(root.modelData);
        root.chooser.close();
    }

    RowLayout {
        anchors {
            left: parent.left;
            verticalCenter: parent.verticalCenter;
            margins: Config.chooser.itemPadding;
        }

        spacing: 8;

        IconImage {
            Layout.alignment: Qt.AlignLeft;
            visible: Config.applauncher.showIcons;
            source: Quickshell.iconPath(modelData.icon ?? "");
            implicitSize: Config.chooser.contentHeight * 0.77;
            mipmap: true;
        }

        Text {
            Layout.alignment: Qt.AlignLeft;
            text: modelData?.name;
            color: selected ? Style.colors.bg0 : Style.colors.fg;
            font.pixelSize: Config.chooser.itemFontSize;
        }
    }
}
