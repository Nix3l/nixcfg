import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, exec } from "astal"

// TODO: change these to functions
export function ControlsModule(): JSX.Element {
    return <box
        vertical
        vexpand
        spacing={12}
    >
        <box className="ControlsModule">
            <button
                onClick={() => print("i will get this set up i promise")}
                className="DesktopControlButton"
            >
                <label label="" />
            </button>
        </box>
        <box className="ControlsModule">
            <button
                onClick=""
                className="DesktopControlButton"
            >
                <label label="" />
            </button>
        </box>
        <box className="ControlsModule">
            <button
                onClick=""
                className="DesktopControlButton"
            >
                <label label="" />
            </button>
        </box>
        <box className="ControlsModule">
            <button
                onClick=""
                className="DesktopControlButton"
            >
                <label label="" />
            </button>
        </box>
    </box>
}
