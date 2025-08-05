pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root;

    readonly property PwNode sink: Pipewire.defaultAudioSink;

    PwObjectTracker {
        objects: [sink]
    }

    function vol(): real {
        return sink?.audio.volume;
    }

    function muted(): bool {
        return sink?.audio.muted;
    }
}
