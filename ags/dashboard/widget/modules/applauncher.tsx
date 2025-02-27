import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import Apps from "gi://AstalApps"

// TODO: fix selected or remove it entirely

const apps = new Apps.Apps();
let selected = Variable(0);

function AppLaunch(app: Apps.Application) {
    app.launch();
}

function AppEntry({ app, index }: { app: Apps.Application; index: number }): JSX.Element {
    return <button
        onClick={() => AppLaunch(app)}
        className={bind(selected).as(i => i == index ? "AppEntrySelected" : "AppEntry")}
    >
        <box
            spacing={8}
        >
            <icon icon={app.icon_name} />
            <label label={app.name} />
        </box>
    </button>
}

export function AppLauncherModule(): JSX.Element {
    let text = Variable("");
    let app_list = bind(text).as(prompt => apps.fuzzy_query(prompt));

    let length = bind(app_list).as(list => list.length).get();
    if(selected.get() > length) selected.set(length);
    if(selected.get() < 0) selected.set(0);

    return <box
        vertical
        vexpand
        widthRequest={380}
        spacing={8}
        className="AppLauncherModule"
    >
        <entry
            placeholderText="Search"
            text={text.get()}
            onChanged={(self) => text.set(self.text)}
            onActivate={() => AppLaunch(app_list.get()[0])}
            className={bind(text).as(input => input.length > 0 ? "FilledPrompt" : "EmptyPrompt")}
        />
        <scrollable
            hscroll={Gtk.PolicyType.NEVER}
            className="AppsContainer"
        >
            <box
                vertical
                vexpand
                spacing={4}
            > {
                bind(app_list).as(list =>
                    list.length > 0 ? list
                    .sort((a, b) => b.frequency - a.frequency)
                    .map((app, i) => (<AppEntry app={app} index={i} />)) :
                    (<centerbox
                        valign={Gtk.Align.CENTER}
                    > <label className="NoMatch" label="idiot" /> </centerbox>)
                )
            }
            </box>
        </scrollable>
    </box>
}
