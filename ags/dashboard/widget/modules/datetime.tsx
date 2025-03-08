import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import { FixTimeDigits } from "../util/utils"

let time_hm = Variable("").poll(1000, () => {
    let date = new Date();
    let hours = date.getHours();
    let minutes = date.getMinutes();

    return FixTimeDigits(hours) + ":" +
           FixTimeDigits(minutes);
});

let time_s = Variable("").poll(1000, () => {
    let date = new Date();
    let seconds = date.getSeconds();

    return FixTimeDigits(seconds);
});

let day = Variable("00").poll(1000, () => FixTimeDigits(new Date().getDate()));
let month = Variable("00").poll(1000, () => FixTimeDigits(new Date().getMonth() + 1));
let year = Variable("00").poll(1000, () => FixTimeDigits(new Date().getFullYear() - 2000));

export function TimeModule(): JSX.Element {
    return <box
        className="TimeModule"
    >
        <box 
            hexpand
            spacing={12}
            halign={Gtk.Align.CENTER}
        >
            <label
                halign={Gtk.Align.CENTER}
                label={bind(time_hm)}
                className="Time"
            />
            <label
                valign={Gtk.Align.END}
                heightRequest={48}
                label={bind(time_s)}
                className="Seconds"
            />
        </box>
    </box>
}

export function DateModule(): JSX.Element {
    return <box
        vertical
        vexpand
        spacing={12}
        className="DateModule"
    >
        <label label={bind(day)} />
        <label label={bind(month)} />
        <label label={bind(year)} />
    </box>
}
