import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, exec } from "astal"

function ControlButton({ label, action } : { label: string; action: () => void; }): JSX.Element {
    return <box
        className="ControlsModule"
    >
        <button
            onClick={() => action()}
        >
            <label label={label} />
        </button>
    </box>
}

export function ControlsModule(): JSX.Element {
    return <box
        vertical
        spacing={15}
    >
        <ControlButton label="" action={() => exec("shutdown -P now")} />
        <ControlButton label="" action={() => exec("systemctl suspend")} />
        <ControlButton label="" action={() => exec("reboot")} />
        <ControlButton label="" action={() => exec("hyprctl dispatch exit")} />
    </box>
}
