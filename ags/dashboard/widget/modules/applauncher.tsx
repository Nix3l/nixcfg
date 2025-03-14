import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import Apps from "gi://AstalApps"

const apps = new Apps.Apps();

function TrimTitle(title: string, max_len: number): string {
    if(title.length > max_len) {
        title = title.slice(0, max_len - 3);
        title += "...";
    }

    return title;
}

function AppEntry({ app, index }: { app: Apps.Application; index: number }): JSX.Element {
    return <button
        onClick={() => app.launch()}
        className="AppEntry"
    >
        <box
            spacing={12}
        >
            <icon icon={app.icon_name} />
            <label label={TrimTitle(app.name, 16)} />
        </box>
    </button>
}

export function AppLauncherModule(): JSX.Element {
    let text = Variable("");
    let app_list = bind(text).as(prompt => apps.fuzzy_query(prompt));

    return <box
        vertical
        vexpand
        spacing={8}
        widthRequest={380}
        className="AppLauncherModule"
    >
        <entry
            placeholderText="検索"
            text={text.get()}
            onChanged={(self) => text.set(self.text)}
            onActivate={() => app_list.get()[0].launch()}
        />
        <stack
            hexpand
            vexpand
            visibleChildName={bind(app_list).as(list => list.length == 0 ? "none" : "found")}
        >
            <centerbox
                vertical
                hexpand
                vexpand
                name="none"
            >
                <label
                    wrap
                    label="そりゃーないだろ"
                    className="NoMatch"
                />
            </centerbox>
            <scrollable
                hscroll={Gtk.PolicyType.NEVER}
                className="AppsContainer"
                name="found"
            >
                <box
                    vertical
                    vexpand
                    spacing={4}
                > {
                    bind(app_list).as(list => list
                        .sort((a, b) => b.frequency - a.frequency)
                        .map((app, i) => (<AppEntry app={app} index={i} />))
                    )
                } </box>
            </scrollable>
        </stack>
    </box>
}
