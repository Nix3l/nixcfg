pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root;

    // TODO

    function poweroff() {
        Quickshell.execDetached([
            "systemctl",
            "poweroff"
        ]);
    }

    function reboot() {
        Quickshell.execDetached([
            "systemctl",
            "reboot"
        ]);
    }

    function sleep() {
        Quickshell.execDetached([
            "systemctl",
            "sleep"
        ]);
    }

    function logout() {
        Quickshell.execDetached([
            "hyprctl",
            "dispatch",
            "exit"
        ]);
    }
}
