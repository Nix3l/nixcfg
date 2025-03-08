import { App, Astal, Gtk, Gdk } from "astal/gtk3"

import { TimeModule } from "./modules/datetime"
import { InfoModule } from "./modules/info"
import { NotificationModule } from "./modules/notifications"
import { SettingsModule } from "./modules/settings"
import { TaskTrackerModule } from "./modules/tasktracker"
import { VolumeModule } from "./modules/volume"
import { MediaModule } from "./modules/media"
import { AppLauncherModule } from "./modules/applauncher"
import { ControlsModule } from "./modules/controls"
import { DateModule } from "./modules/datetime"

// NOTES!!!
// -> General:
//      => do a design overhaul
// -> Notifications:
//      => remove the ability to scroll horizontally

export default function Dashboard(gdkmonitor: Gdk.Monitor) {
    return <window
	    gdkmonitor={gdkmonitor}
        layer={Astal.Layer.OVERLAY}
	    exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.EXCLUSIVE}
        onKeyPressEvent={(self, event: Gdk.Event) => {
            if (event.get_keyval()[1] === Gdk.KEY_Escape) {
               self.close();
               App.quit();
            }
        }}
	    application={App}
	    className="Dashboard"
    >
    <box
        hexpand
        vexpand
        heightRequest={640}
        spacing={24}
    >
        <box
            vexpand
            vertical
            spacing={24}
            halign={Gtk.Align.START}
        >
            <TimeModule />
            <InfoModule />
        </box>
        <box
            vexpand
            vertical
            spacing={24}
            halign={Gtk.Align.CENTER}
        >
            <box
                halign={Gtk.Align.START}
                spacing={24}
            >
                <NotificationModule />
                <box
                    vexpand
                    vertical
                    spacing={24}
                >
                    <SettingsModule />
                    <TaskTrackerModule />
                </box>
            </box>
            <VolumeModule />
        </box>
        <box
            vexpand
            vertical
            spacing={24}
            halign={Gtk.Align.END}
        >
            <MediaModule />
            <box
                vexpand
                spacing={24}
            >
                <AppLauncherModule />
                <box
                    vexpand
                    vertical
                    spacing={15}
                >
                    <ControlsModule />
                    <DateModule />
                </box>
            </box>
        </box>
    </box>
    </window>
}
