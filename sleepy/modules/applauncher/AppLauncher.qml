import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components/chooser"

Chooser {
    id: root;

    isVisible: () => GlobalState.choosers.applauncher;
    toggle: (on) => { GlobalState.choosers.applauncher = on; }

    model: Apps.entries.filter(app => app.name.toLocaleLowerCase().includes(promptText.toLocaleLowerCase()));
    modelItem: Component {
        id: listItem;
        AppItem { chooser: root; }
    }
}
