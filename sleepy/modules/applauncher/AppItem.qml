import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/services"

MouseArea {
    id: root;

    required property DesktopEntry modelData;
    property bool selected: ListView.isCurrentItem;

    acceptedButtons: Qt.LeftButton;
    hoverEnabled: true;

    implicitWidth: Config.applauncher.itemWidth;
    implicitHeight: Config.applauncher.itemHeight;

    Rectangle {
        anchors.fill: parent;
        color: root.selected ? Style.colors.bg1 : Style.colors.bg0;
    }

    RowLayout {
        id: content;

        anchors {
            left: parent.left;
            verticalCenter: parent.verticalCenter;
            leftMargin: Config.applauncher.padding;
        }

        IconImage {
            source: Quickshell.iconPath(root.modelData?.icon, "image-missing");
            implicitSize: 28;
            mipmap: true;
        }

        Text {
            text: modelData?.name;
            color: Style.colors.fg;
            font.pixelSize: 14;
        }
    }

    onEntered: { selected = true; }
    onExited: { selected = ListView.isCurrentItem; }

    onPressed: {
        Apps.run(root.modelData);
        GlobalState.applauncherOpen = false;
    }
}
