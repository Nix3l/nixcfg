import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"

PanelWindow {
    id: root;
    visible: isVisible();

    exclusionMode: ExclusionMode.Ignore;

    required property var isVisible;
    required property var toggle;

    property color bg: Style.colors.bg0;
    property real bgOpacity: 0.8;

    property int border: 2;
    property color borderColor: Style.colors.accent;

    required property var model;
    required property Component modelItem;

    property bool usePrompt: true;
    property string promptText: searchPrompt.field.text ?? "";

    function close() {
        searchPrompt.field.text = "";
        root.toggle(false);
    }

    anchors {
        top: true;
        right: true;
        bottom: true;
        left: true;
    }

    color: 'transparent';

    WlrLayershell.layer: WlrLayer.Overlay;
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand;
    HyprlandFocusGrab {
        active: root.isVisible();
        windows: [ root ];
        onCleared: root.close();
    }

    Shortcut {
        sequences: [ StandardKey.Cancel ];
        onActivated: root.close();
    }

    Rectangle {
        anchors.fill: parent;
        color: root.bg;
        opacity: root.bgOpacity;
        border {
            width: root.border;
            color: root.borderColor;
        }
    }

    ColumnLayout {
        id: content;
        anchors.centerIn: parent;
        spacing: Config.chooser.contentSpacing;

        ChooserPrompt {
            id: searchPrompt;
            visible: root.usePrompt;
        }

        ClippingRectangle {
            implicitWidth: Config.chooser.contentWidth;
            implicitHeight: Config.chooser.maxShownItems * (Config.chooser.itemHeight + Config.chooser.itemSpacing) - Config.chooser.itemSpacing;

            color: 'transparent';

            ListView {
                id: listview;
                anchors.fill: parent;
                orientation: Qt.Vertical;
                spacing: Config.chooser.itemSpacing;

                model: root.model;
                delegate: root.modelItem;

                keyNavigationEnabled: true;
                keyNavigationWraps: true;
            }
        }
    }
}
