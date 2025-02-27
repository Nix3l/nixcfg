import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import Mpris from "gi://AstalMpris"

const player = Mpris.Player.new("spotify");

export function MediaModule(): JSX.Element {
    return <centerbox
        className="MediaModule"
    >
        <button
            halign={Gtk.Align.END}
            hexpand
            onClick={() => { if(player.available) player.previous() }}
            cursor="pointer"
            className="MediaControlButton"
        >
            <label className="PreviousControl" label="<" />
        </button>
        <button
            onClick={() => { if(player.available) player.play_pause() }}
            cursor="pointer"
            className="MediaControlButton"
        >
            <label className="PlayPauseControl" label={
                bind(player, "playback_status").as(status =>
                    status == Mpris.PlaybackStatus.PLAYING ? "" : ""
                )
            } />
        </button>
        <button
            halign={Gtk.Align.START}
            onClick={() => { if(player.available) player.next() }}
            cursor="pointer"
            className="MediaControlButton"
        >
            <label className="NextControl" label=">" />
        </button>
    </centerbox>
}
