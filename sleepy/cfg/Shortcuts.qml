import Quickshell
import QtQuick

import "root:/components"

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
            GlobalState.choosers.applauncher = true;
        }
    }
}
