import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import Notifd from "gi://AstalNotifd"

const notifd = Notifd.get_default()

function Notification({ notif }: { notif: Notifd.Notification }): JSX.Element {
    return <box
        hexpand
        spacing={12}
        className="Notif"
    >
        <icon icon={notif.get_app_icon() || "./assets/notification.svg"} />
        <box
            hexpand
            vertical
            spacing={8}
            halign={Gtk.Align.START}
        >
            <label
                halign={Gtk.Align.START}
                label={`${notif.get_app_name()} | ${notif.get_summary()}`} className="Header"
            />
            <label
                wrap
                halign={Gtk.Align.START}
                label={notif.get_body()} className="Body"
            />
        </box>
        <button
            onClick={() => notif.dismiss()}
            halign={Gtk.Align.END}
            className="Dismiss"
        >
            <label label="" />
        </button>
    </box>
}

export function NotificationModule(): JSX.Element {
    return <box
        vertical
        widthRequest={520}
        className="NotificationModule"
    >
        <box hexpand>
            <label label="Notification Centre" halign={Gtk.Align.START} />
            <box
                hexpand
                halign={Gtk.Align.END}
            >
                <button
                    cursor="pointer"
                    onClick={() => {
                        for(let notif of notifd.get_notifications())
                            notif.dismiss();
                    }}
                    className="Clear"
                >
                    <label label="" />
                </button>
            </box>
        </box>
        <scrollable
            hscroll={Gtk.PolicyType.NEVER}
        >
            <box
                vertical
                vexpand
                hexpand
                spacing={6}
                className="Notifications"
            > {
                bind(notifd, "notifications").as(list => list
                    .map(notif => 
                        (<Notification notif={notif} />)
                ))
            } </box>
        </scrollable>
    </box>
}
