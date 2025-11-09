import Quickshell
import QtQuick

import "root:/cfg"

QtObject {
    id: root;

    required property string ssid;
    property string security: "-";
    property bool connected: false;
    property int strength: 0;
    property int bandwidth: 0;
    property int rate: 0; // mbit/s
}
