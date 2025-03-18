import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import Notifd from "gi://AstalNotifd"

const notifd = Notifd.get_default()

function NotificationIcon(notif: Notifd.Notification): string {
    if(notif.image != "")
        return notif.image;

    if(notif.app_icon != "")
        return notif.image;

    return "../assets/notification.svg";
}

function TrimTitle(str: string, max_len: number): string {
    if(str.length > max_len) {
        str = str.slice(0, str.length - 3);
        str += "...";
    }

    return str;
}

function Notification({ notif }: { notif: Notifd.Notification }): JSX.Element {
    return <box
        hexpand
        spacing={12}
        className="Notif"
    >
        <centerbox
            widthRequest={40}
            className="Icon"
        >
            <icon
                icon={NotificationIcon(notif)}
                className={notif.app_name == "" && notif.image == "" ? "Fallback" : ""}
            />
        </centerbox>
        <box
            hexpand
            vertical
            spacing={6}
            halign={Gtk.Align.START}
        >
            <box
                hexpand
                spacing={4}
                className="Header"
            >
                <label
                    halign={Gtk.Align.START}
                    label={TrimTitle(notif.app_name, 22)}
                />
            </box>
            <box
                vertical
                hexpand
                spacing={4}
                className="Body"
            >
                <label
                    wrap
                    halign={Gtk.Align.START}
                    label={"> " + notif.summary}
                />
                <label
                    wrap
                    halign={Gtk.Align.START}
                    label={notif.body}
                />
            </box>
        </box>
        <button
            cursor="pointer"
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
            <label
                halign={Gtk.Align.START}
                label="Notification Centre"
                className="Title"
            />
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
        <scrollable >
            <box
                vertical
                vexpand
                hexpand
                spacing={6}
                className="Notifications"
            > {
                bind(notifd, "notifications").as(list => list
                    .sort((a,b) => b.time - a.time)
                    .map(notif => 
                        (<Notification notif={notif} />)
                ))
            } </box>
        </scrollable>
    </box>
}
