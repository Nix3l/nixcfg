import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, exec } from "astal"

function ControlButton({ name, label, action } : { name: string; label: string; action: () => void; }): JSX.Element {
    return <centerbox
        className="ControlsModule"
    >
        <button
            cursor="pointer"
            onClick={() => action()}
            className={name}
        >
            <label label={label} />
        </button>
    </centerbox>
}

export function ControlsModule(): JSX.Element {
    return <box
        vertical
        spacing={15}
    >
        <ControlButton name="Shutdown" label="" action={() => exec("shutdown -P now")} />
        <ControlButton name="Sleep" label="" action={() => exec("systemctl suspend")} />
        <ControlButton name="Reboot" label="" action={() => exec("reboot")} />
        <ControlButton name="Logout" label="" action={() => exec("hyprctl dispatch exit")} />
    </box>
}
