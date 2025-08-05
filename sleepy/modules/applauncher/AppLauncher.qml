import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/services"

PanelWindow {
    id: root;
    visible: GlobalState.applauncherOpen;
    WlrLayershell.layer: WlrLayer.Top;
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand;

    implicitWidth: Config.applauncher.width;
    implicitHeight: Config.applauncher.height;
    color: 'transparent';

    Rectangle {
        anchors.fill: parent;
        color: Style.colors.bg0;

        border {
            color: Style.colors.fg;
            width: Config.applauncher.border;
        }
    }

    HyprlandFocusGrab {
        active: GlobalState.applauncherOpen;
        windows: [ root ];
        onCleared: {
            GlobalState.applauncherOpen = false;
        }
    }

    Shortcut {
        sequences: [ StandardKey.Cancel ];
        onActivated: GlobalState.applauncherOpen = false;
    }

    ColumnLayout {
        anchors {
            fill: parent;
            centerIn: parent;
            margins: Config.applauncher.padding;
        }

        spacing: 12;

        SearchPrompt {
            id: searchprompt;

            field.onAccepted: {
                let app = Apps.query(text)[0];
                if(app != null) {
                    Apps.run(app)
                    GlobalState.applauncherOpen = false;
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true;
            implicitHeight: 1;
            color: Style.colors.fgMuted;
        }

        AppList { search: searchprompt.field; }
    }
}
