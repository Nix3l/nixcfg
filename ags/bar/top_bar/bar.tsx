import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, execAsync } from "astal"

// libraries
import Hyprland from "gi://AstalHyprland"
import Tray from "gi://AstalTray"

// ngl i hate having to use pascal case but whatever

const hyprland = Hyprland.get_default();
const tray = Tray.get_default();

// DASHBOARD
function OpenDashboard() {
    execAsync("ags run ../dashboard/app.ts");
}

function Dashboard(): JSX.Element {
    return <button
        className="DashboardLauncher"
        onClicked={() => OpenDashboard()}
    >
        <label label="" />
    </button>;
}

// WORKSPACES
function Workspaces(): JSX.Element {
    const focused_ws = bind(hyprland, "focusedWorkspace");
    return <box className="Workspaces"> {
        Array.from({ length: 4 }).map((_, i) =>
            <button
		heightRequest={10}
                onClicked={() => hyprland.message(`dispatch workspace ${i + 1}`)}
                className={focused_ws.as(fw => i + 1 === fw.id ? "Focused" : "")}
	    >
            </button>
        )
    } </box>;
};

// FOCUSED WINDOW
function FocusedClient(): JSX.Element {
    const client = bind(hyprland, "focusedClient");
    return <box
        className="FocusedClient"
        visible={client.as(Boolean)}
    > {
        <label label={client.as(c => c.get_title())} />
    } </box>;
};

// TRAY
let tray_open = Variable(false);

function SysTrayToggle() {
    tray_open.set(!tray_open.get());
}

function SysTray(): JSX.Element {
    return <box className="Tray">
        <button
            className="TrayToggle"
            cursor="pointer"
            onClick={() => SysTrayToggle() }
        >
            <label label={ bind(tray_open).as(v => v ? ">" : "<") } />
        </button>
        <revealer
            revealChild={bind(tray_open).as(v => v)}
            transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
            transitionDuration={300}
        >
            <box className="TrayContents"> {
                bind(tray, "items").as(items => items
                    .map(item =>
                        <menubutton
                            className="TrayItem"
                            tooltipMarkup={bind(item, "tooltipMarkup")}
                            usePopover={false}
                            actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
                            menuModel={bind(item, "menuModel")}
                        >
                            <icon gicon={bind(item, "gicon")} />
                        </menubutton>
                ))
            } </box>
        </revealer>
    </box>
}

// BAR
export default function TopBar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

    return <window
        className="Bar"
        gdkmonitor={ gdkmonitor }
        exclusivity={ Astal.Exclusivity.EXCLUSIVE }
        anchor={ TOP | LEFT | RIGHT } // anchor the bar to the top left, top center and top right of the screen
        application={App}>
        <box>
            <box hexpand halign={Gtk.Align.START} className="LeftBox">
                <Dashboard />
                <Workspaces />
            </box>
            <box hexpand halign={Gtk.Align.CENTER} className="CenterBox">
                <FocusedClient />
            </box>
            <box hexpand halign={Gtk.Align.END} className="RightBox">
                <SysTray />
            </box>
        </box>
    </window>;
}
