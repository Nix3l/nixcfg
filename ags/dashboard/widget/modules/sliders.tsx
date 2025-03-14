import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, exec } from "astal"

// WIREPLUMBER
import Wp from "gi://AstalWp"

const wp = Wp.get_default();
const audio = wp?.audio as Wp.Audio;

const max_brightness = Number(exec(`bash -c 'brightnessctl m'`));

function Mute() {
    audio.defaultSpeaker.set_mute(!audio.defaultSpeaker.get_mute());
}

function GetBrightness(): number {
    return Number(exec(`bash -c 'brightnessctl g'`));
}

function SetBrightness(brightness: number): number {
    return Number(exec(`bash -c 'brightnessctl s ${brightness}'`));
}

// <icon icon={bind(audio.defaultSpeaker, "volume_icon").as(String)} />
export function SlidersModule(): JSX.Element {
    return <box
        hexpand
        spacing={8}
        className="SlidersModule"
    >
        <box
            spacing={8}
            widthRequest={10}
            className="Volume"
        >
            <button
                onClick={() => Mute()}
            >
                <icon icon={bind(audio.defaultSpeaker, "volume_icon").as(String)} />
            </button>
            <slider
                hexpand
                drawValue={false}
                cursor="pointer"
                value={bind(audio.defaultSpeaker, "volume").as(Number)}
                onDragged={self => audio.defaultSpeaker.set_volume(self.value)}
                className="Slider"
            />
        </box>
        <box
            spacing={8}
            className="Brightness"
        >
            <label label="" className="icon" />
            <slider
                hexpand
                drawValue={false}
                cursor="pointer"
                heightRequest={24}
                value={GetBrightness() / max_brightness}
                onDragged={(self) => SetBrightness((0.1 + self.value * 0.9) * max_brightness)}
            />
        </box>
    </box>
}
