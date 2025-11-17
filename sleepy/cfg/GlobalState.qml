pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root;

    property JsonObject drawers: JsonObject {
        property bool media: false;
        property bool notifs: false;
        property bool dashboard: false;
        property bool bluetooth: false;
        property bool network: false;
    }

    property JsonObject choosers: JsonObject {
        property bool applauncher: false;
    }
}
