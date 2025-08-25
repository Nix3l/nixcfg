pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root;

    readonly property UPowerDevice device: UPower.displayDevice;
    readonly property bool onBattery: UPower.onBattery;
    readonly property bool charging: device.changeRate >= 0;
    readonly property real percentage: device.percentage;
    readonly property real health: device.healthPercentage;
    readonly property string icon: device.iconName;

    function timeToEmptyStr(): string {
        return "" + device.timeToEmpty;
    }

    function timeToFullStr(): string {
        return "" + device.timeToFull;
    }

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
