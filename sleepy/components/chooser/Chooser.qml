import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/components"

PanelWindow {
    id: root;
    visible: isVisible();

    exclusionMode: ExclusionMode.Ignore;

    required property var isVisible;
    required property var toggle;

    property color bg: Style.colors.bg0;
    property real bgOpacity: 0.96;

    property int border: Style.border.thick;
    property color borderColor: Style.colors.acc1;

    required property var model;
    required property Component modelItem;

    property bool usePrompt: true;
    property string promptText: searchPrompt.field.text ?? "";

    // kinda stupid but it works
    onVisibleChanged: {
        if(visible) open();
        else close();
    }

    function open() {
        toggleFocus(false);
        toggle(true);
    }

    function close() {
        searchPrompt.field.text = "";
        listview.currentIndex = 0;
        listview.positionViewAtBeginning();
        root.toggle(false);
    }

    anchors {
        top: true;
        right: true;
        bottom: true;
        left: true;
    }

    color: "transparent";

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

    StyledBg {
        color: root.bg;
        opacity: root.bgOpacity;
        border.width: root.border;
    }

    ColumnLayout {
        id: content;
        anchors.centerIn: parent;
        spacing: Config.chooser.contentSpacing;

        ChooserPrompt {
            id: searchPrompt;
            visible: root.usePrompt;
            Keys.onPressed: event => processKeys(event);
        }

        StyledList {
            implicitWidth: Config.chooser.contentWidth;
            implicitHeight: Config.chooser.maxShownItems * (Config.chooser.itemHeight + Config.chooser.itemSpacing) - Config.chooser.itemSpacing;
            spacing: Config.chooser.itemSpacing;

            items {
                id: listview;
                model: root.model;
                delegate: root.modelItem;
                keyNavigationEnabled: true;
                Keys.onPressed: event => processKeys(event);
            }
        }
    }

    function toggleFocus(listFocus: bool) {
        searchPrompt.field.focus = !listFocus;
        listview.focus = listFocus;
    }

    function processKeys(event: KeyEvent) {
        if(event.key == Qt.Key_Down && !listview.focus) {
            toggleFocus(true);
            listview.incrementCurrentIndex();
        }

        if(event.key == Qt.Key_Up && !listview.focus) {
            toggleFocus(true);
            listview.decrementCurrentIndex();
        }

        if(event.key == Qt.Key_Return) {
            if(listview.currentItem.activate != undefined) listview.currentItem.activate();
        }
    }
}
