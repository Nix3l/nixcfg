import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import { TimeModule } from "./modules/time"
import { InfoModule } from "./modules/info"
import { NotificationModule } from "./modules/notifications"
import { SettingsModule } from "./modules/settings"
import { TaskTrackerModule } from "./modules/tasktracker"
import { VolumeModule } from "./modules/volume"
import { MediaModule } from "./modules/media"
import { AppLauncherModule } from "./modules/applauncher"
import { ControlsModule } from "./modules/controls"

// NOTES!!!
// -> General:
//      =>
// -> Notifications:
//      => remove the ability to scroll horizontally

export default function Dashboard(gdkmonitor: Gdk.Monitor) {
    return <window
	    gdkmonitor={gdkmonitor}
        layer={Astal.Layer.OVERLAY}
	    exclusivity={Astal.Exclusivity.EXCLUSIVE}
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
            vertical
            spacing={24}
            halign={Gtk.Align.START}
            vexpand
        >
            <TimeModule />
            <InfoModule />
        </box>
        <box
            vertical
            spacing={24}
            halign={Gtk.Align.CENTER}
            vexpand
        >
            <box
                halign={Gtk.Align.START}
                spacing={24}
            >
                <NotificationModule />
                <box
                    vertical
                    vexpand
                    spacing={24}
                >
                    <SettingsModule />
                    <TaskTrackerModule />
                </box>
            </box>
            <VolumeModule />
        </box>
        <box
            vertical
            vexpand
            spacing={24}
            halign={Gtk.Align.END}
        >
            <MediaModule />
            <box vexpand spacing={24}>
                <AppLauncherModule />
                <ControlsModule />
            </box>
        </box>
    </box>
    </window>
}
