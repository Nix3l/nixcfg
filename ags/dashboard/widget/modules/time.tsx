import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

let time = Variable(new Date().toLocaleTimeString()).poll(1000, () => new Date().toLocaleTimeString());

export function TimeModule(): JSX.Element {
    return <centerbox className="TimeModule">
        <label
            label={bind(time).as(v => v.toString())}
            className="Time"
        />
    </centerbox>
}
