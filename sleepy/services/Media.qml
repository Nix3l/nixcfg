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

    property int minutes: 0;
    property int seconds: 0;

    property int lengthMinutes: 0;
    property int lengthSeconds: 0;

    readonly property string cursorTimeText: Time.paddedTimeStr(minutes, seconds);
    readonly property string lengthText: Time.paddedTimeStr(lengthMinutes, lengthSeconds);

    readonly property bool playing: playerOpen && active?.playbackState == MprisPlaybackState.Playing;

    readonly property string shortenedTrackTitle: playerOpen ? shortenStr(active.trackTitle) : "";
    readonly property string shortenedAlbumTitle: playerOpen ? shortenStr(active.trackAlbum) : "";

    Timer {
        running: playerOpen;
        repeat: true;
        interval: 800;
        onTriggered: {
            const cursorTime = Time.timeFromSeconds(active.position);
            minutes = cursorTime[0];
            seconds = cursorTime[1];
            const lengthTime = Time.timeFromSeconds(active.length);
            lengthMinutes = lengthTime[0];
            lengthSeconds = lengthTime[1];
        }
    }

    // TODO: these probably shouldnt be here
    function shortenStr(str: string): string {
        return shortenStrFrom(str, ["-", "(", ":"]);
    }

    function shortenStrFrom(str: string, chars: list<string>): string {
        let shortened = "";

        // HORRIBLE
        // genuinely AWFUL
        // you can do better idiot
        for(let i = 0; i < str.length; i ++) {
            let breakFound = false;
            let checkIndex = i;
            if(str[i] == " " && i != str.length - 1) checkIndex ++;

            for(let j = 0; j < chars.length; j ++) {
                if(str[checkIndex] == chars[j][0]) {
                    breakFound = true;
                    break;
                }
            }

            if(breakFound) break;
            shortened += str[i];
        }

        return shortened;
    }
}
