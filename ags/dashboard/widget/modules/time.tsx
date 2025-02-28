import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

function FixDigits(x: number): string {
    return x < 10 ? "0" + x : x.toString();
}

let time_hm = Variable("").poll(1000, () => {
    let date = new Date();
    let hours = date.getHours();
    let minutes = date.getMinutes();

    return FixDigits(hours) + ":" +
           FixDigits(minutes);
});

let time_s = Variable("").poll(1000, () => {
    let date = new Date();
    let seconds = date.getSeconds();

    return FixDigits(seconds);
});

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
