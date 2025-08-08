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
        property string unread: "root:/res/notif_unread.svg";
        property string read:   "root:/res/notif_default.svg";
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

    function wifiStrengthIcon(strength: int): string {
        if(strength >= 80) return root.wifi.bars_4;
        if(strength >= 60) return root.wifi.bars_3;
        if(strength >= 40) return root.wifi.bars_2;
        if(strength >= 20) return root.wifi.bars_1;
        else return root.wifi.bars_0;
    }
}
