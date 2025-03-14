import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import Mpris from "gi://AstalMpris"

const player = Mpris.Player.new("spotify");

function TrimTitle(title: string, max_len: number): string {
    const trim_characters = ["(", "[", "-"];
    for(let i = 1; i < title.length; i ++) {
        if(trim_characters.find((c) => c === title[i]) != undefined) {
            title = title.slice(0, title[i - 1] === " " ? i - 1 : i);
        }
    }

    if(title.length > max_len) {
        title = title.slice(0, max_len - 3);
        title += "...";
    }

    return title;
}

export function MediaModule(): JSX.Element {
    return <box
        hexpand
        className="MediaModule"
    >
        <box
            hexpand
            spacing={12}
            className="Info"
        >
            <label label="" />
            <box
                vertical
                hexpand
                halign={Gtk.Align.START}
                valign={Gtk.Align.CENTER}
                spacing={4}
            >
                <label
                    wrap
                    halign={Gtk.Align.START}
                    label={bind(player, "title").as(title => player.available ? TrimTitle(title, 26) : "No Track")}
                    className="Major"
                />
                <label
                    wrap
                    halign={Gtk.Align.START}
                    label={bind(player, "album").as(album => player.available ?
                            album.length > 36 ? player.album_artist : TrimTitle(album, 32) : "")}
                    className="Minor"
                />
            </box>
        </box>
        <centerbox
            halign={Gtk.Align.END}
        >
            <button
                halign={Gtk.Align.END}
                hexpand
                cursor="pointer"
                onClick={() => { if(player.available) player.previous() }}
                className="Control"
            >
                <label className="Previous" label="<" />
            </button>
            <button
                cursor="pointer"
                onClick={() => { if(player.available) player.play_pause() }}
                className="Control"
            >
                <label className="PlayPause" label={
                    bind(player, "playback_status").as(status =>
                        status == Mpris.PlaybackStatus.PLAYING ? "" : ""
                    )
                } />
            </button>
            <button
                halign={Gtk.Align.START}
                cursor="pointer"
                onClick={() => { if(player.available) player.next() }}
                className="Control"
            >
                <label className="Next" label=">" />
            </button>
        </centerbox>
    </box>
}
