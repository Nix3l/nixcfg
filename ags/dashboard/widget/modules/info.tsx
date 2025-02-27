import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

export function InfoModule(): JSX.Element {
    return <centerbox
        vertical
        hexpand
        vexpand
        className="InfoModule"
    >
        <box
            vertical
            hexpand
            valign={Gtk.Align.CENTER}
            spacing={24}
        >
            <icon icon="./assets/king-terry.jpeg" className="pfp" />
            <label
                label={`\"God's Loneliest Programmer\"`}
                className="InfoText"
            />
        </box>
    </centerbox>
}
