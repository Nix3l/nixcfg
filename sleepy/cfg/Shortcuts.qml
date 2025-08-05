import Quickshell
import QtQuick

import "root:/util"

Scope {
    id: root;

    CustomShortcut {
        name: "reload";
        description: "Hard reloads quickshell";
        onReleased: {
            Quickshell.reload(true);
        }
    }

    CustomShortcut {
        name: "applauncher_open";
        description: "Opens the application launcher";
        onReleased: {
            GlobalState.applauncherOpen = true;
        }
    }
}
