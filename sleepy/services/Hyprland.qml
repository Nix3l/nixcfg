pragma Singleton

import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root;

    readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values;
    readonly property HyprlandWorkspace activeWorkspace: Hyprland.focusedWorkspace;
}
