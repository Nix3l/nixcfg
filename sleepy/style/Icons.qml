pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root;

    property QtObject wifi: QtObject {
        property string bars_0: "root:/res/wifi_0bar.svg";
        property string bars_1: "root:/res/wifi_1bar.svg";
        property string bars_2: "root:/res/wifi_2bar.svg";
        property string bars_3: "root:/res/wifi_3bar.svg";
        property string bars_4: "root:/res/wifi_4bar.svg";
        property string off:    "root:/res/wifi_off.svg";
    }

    property QtObject notifs: QtObject {
        property string unread:  "root:/res/notif_unread.svg";
        property string read:    "root:/res/notif_default.svg";
        property string garbage: "root:/res/garbage.svg";
    }

    property QtObject os: QtObject {
        property string nixos: "root:/res/nixos.png";
    }

    property QtObject media: QtObject {
        property string music:       "root:/res/music.svg";
        property string fastforward: "root:/res/fastforward.svg";
        property string rewind:      "root:/res/rewind.svg";
        property string play:        "root:/res/play.svg";
        property string pause:       "root:/res/pause.svg";
    }

    property QtObject power: QtObject {
        property string battery_0bar:     "root:/res/battery_0bar.svg";
        property string battery_1bar:     "root:/res/battery_1bar.svg";
        property string battery_2bar:     "root:/res/battery_2bar.svg";
        property string battery_3bar:     "root:/res/battery_3bar.svg";
        property string battery_4bar:     "root:/res/battery_4bar.svg";
        property string battery_5bar:     "root:/res/battery_5bar.svg";
        property string battery_6bar:     "root:/res/battery_6bar.svg";
        property string battery_7bar:     "root:/res/battery_7bar.svg";
        property string battery_charging: "root:/res/battery_charging.svg";
        property string poweroff:         "root:/res/poweroff.svg";
        property string reboot:           "root:/res/reboot.svg";
        property string logout:           "root:/res/logout.svg";
        property string sleep:            "root:/res/sleep.svg";
    }

    property QtObject audio: QtObject {
        property string vol_mute:   "root:/res/vol_mute.svg";
        property string vol_low:    "root:/res/vol_low.svg";
        property string vol_medium: "root:/res/vol_medium.svg";
        property string vol_high:   "root:/res/vol_high.svg";
    }

    property QtObject display: QtObject {
        property string brightness: "root:/res/brightness.svg";
    }

    property QtObject bluetooth: QtObject {
        property string enabled:   "root:/res/bluetooth_enabled.svg";
        property string disabled:  "root:/res/bluetooth_disabled.svg";
        property string connected: "root:/res/bluetooth_connected.svg";
    }

    property QtObject controls: QtObject {
        property string menu: "root:/res/menu.svg";   
    }

    property QtObject other: QtObject {
        property string unknown: "root:/res/unknown.svg";
        property string loading: "root:/res/loading.svg";
    }

    function batteryIcon(per: real): string {
        if(per < 0.12) return root.power.battery_0bar;
        if(per < 0.24) return root.power.battery_1bar;
        if(per < 0.36) return root.power.battery_2bar;
        if(per < 0.48) return root.power.battery_3bar;
        if(per < 0.60) return root.power.battery_4bar;
        if(per < 0.72) return root.power.battery_5bar;
        if(per < 0.84) return root.power.battery_6bar;
        return root.power.battery_7bar;
    }

    function volIcon(vol: real): string {
        if(vol < 0.4) return root.audio.vol_low;
        if(vol < 0.7) return root.audio.vol_medium;
        return root.audio.vol_high;
    }

    function volTextIcon(vol: real): string {
        if(vol < 0.4) return "";
        if(vol < 0.7) return "";
        return "";
    }

    function wifiStrengthIcon(strength: int): string {
        if(strength >= 80) return root.wifi.bars_4;
        if(strength >= 60) return root.wifi.bars_3;
        if(strength >= 40) return root.wifi.bars_2;
        if(strength >= 20) return root.wifi.bars_1;
        else return root.wifi.bars_0;
    }
}
