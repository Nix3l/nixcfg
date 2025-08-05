pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    id: root;

    readonly property list<MprisPlayer> players: Mpris.players.values;
    readonly property MprisPlayer active: players.find(p => p.identity === "Spotify") ?? null;
    readonly property bool playerOpen: root.active != null;
}
