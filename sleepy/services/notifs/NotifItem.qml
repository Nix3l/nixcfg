import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/services/notifs"
import "root:/style"

Item {
    id: root;
    visible: modelData != null;

    required property TimedNotif modelData;

    property int border: Config.notifs.border;
    property color borderCol: Style.colors.acc1;
    property color hoveredBorderCol: Style.colors.acc1;

    property var leftClicked: () => { Notifs.dismissNotif(modelData); };

    implicitWidth: Config.notifs.width;
    implicitHeight: Config.notifs.padding + Math.max(Config.notifs.minimumHeight, content.implicitHeight);

    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        acceptedButtons: Qt.LeftButton;
        hoverEnabled: true;
        onPressed: root.leftClicked();
    }

    Rectangle {
        anchors.fill: parent;
        color: Style.colors.bg0;
        border {
            width: root.border;
            color: mouseArea.containsMouse ? root.hoveredBorderCol : root.borderCol;
        }
    }

    RowLayout {
        id: content;

        anchors {
            left: parent.left;
            right: parent.right;
            verticalCenter: parent.verticalCenter;
            margins: Config.notifs.padding;
        }

        IconImage {
            id: icon;
            visible: modelData.hasImage;
            source: modelData.image;
            implicitSize: Config.notifs.minimumHeight - Config.notifs.padding;
            mipmap: true;
        }

        ColumnLayout {
            id: textcol;
            spacing: 4;

            Text {
                text: modelData.header;
                color: Style.colors.fg1;
                Layout.preferredWidth: Config.notifs.width - icon.implicitWidth - Config.notifs.padding * 2;
                font.pixelSize: 14;
                wrapMode: Text.Wrap;
                elide: Text.ElideRight;
            }

            Text {
                text: modelData.body;
                color: Style.colors.fg1;
                font.pixelSize: 11;
                Layout.preferredWidth: Config.notifs.width - icon.implicitWidth - Config.notifs.padding * 2;
                maximumLineCount: 3;
                wrapMode: Text.Wrap;
                elide: Text.ElideRight;
            }
        }
    }
}
