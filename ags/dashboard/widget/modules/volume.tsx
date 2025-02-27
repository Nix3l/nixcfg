import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

// WIREPLUMBER
import Wp from "gi://AstalWp"

const wp = Wp.get_default();
const audio = wp?.audio as Wp.Audio;

function Mute() {
    audio.defaultSpeaker.set_mute(!audio.defaultSpeaker.get_mute());
}

// <icon icon={bind(audio.defaultSpeaker, "volume_icon").as(String)} />
export function VolumeModule(): JSX.Element {
    return <box
        spacing={8}
        className="VolumeModule"
    >
        <button
            onClick={() => Mute()}
            className="VolumeButton"
        >
            <icon icon={bind(audio.defaultSpeaker, "volume_icon").as(String)} />
        </button>
        <slider
            hexpand
            drawValue={false}
            cursor="pointer"
            value={bind(audio.defaultSpeaker, "volume").as(Number)}
            onDragged={self => audio.defaultSpeaker.set_volume(self.value)}
            className="VolumeSlider"
        />
    </box>
}
