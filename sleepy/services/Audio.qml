pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root;

    readonly property PwNode sink: Pipewire.defaultAudioSink;

    PwObjectTracker {
        objects: [ sink ];
    }

    function volume(): real {
        return sink?.audio.volume ?? 0.0;
    }

    function muted(): bool {
        return sink?.audio.muted ?? false;
    }

    function setVolume(volume: real) {
        if(sink == undefined) return;
        sink.audio.volume = volume;
    }

    function setMuted(mute: bool) {
        if(sink == undefined) return;
        sink.audio.muted = mute;
    }

    function toggleMuted() {
        setMuted(!muted());
    }
}
