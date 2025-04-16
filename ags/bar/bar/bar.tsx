import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, execAsync } from "astal"

// libraries
import Hyprland from "gi://AstalHyprland"
import Tray from "gi://AstalTray"
import Wp from "gi://AstalWp"
import Battery from "gi://AstalBattery"

// ngl i hate having to use pascal case but whatever
function FixDigits(x: number): string {
    return x < 10 ? "0" + x : x.toString();
}

const hyprland = Hyprland.get_default();
let time = Variable("00:00").poll(1000, () => {
    let date = new Date();
    return FixDigits(date.getHours()) + ":" + FixDigits(date.getMinutes());
});

let day = Variable("").poll(1000, () => {
    let date = new Date();
    let days = [ "日", "月", "火", "水", "木", "金", "土" ];
    return days[date.getDay()];
});

const wp = Wp.get_default();
const speaker = wp?.default_speaker as Wp.Endpoint;

const battery = Battery.get_default();

const tray = Tray.get_default();
let tray_open = Variable(false);

// LEFT
function Dashboard(): JSX.Element {
    return <button
        className="DashboardLauncher"
        onClicked={() => execAsync("ags run ../dashboard/app.ts")}
    >
        <label label="" />
    </button>
}

function Workspaces(): JSX.Element {
    const focused_ws = bind(hyprland, "focusedWorkspace");
    return <box className="Workspaces"> {
        Array.from({ length: 4 }).map((_, i) => (
            <box
                vertical
                valign={Gtk.Align.CENTER}
                heightRequest={15}
            >
                <button
                    heightRequest={15}
                    onClicked={() => hyprland.message(`dispatch workspace ${i + 1}`)}
                    className={focused_ws.as(fw => i + 1 === fw.id ? "Focused" : "")}
                />
            </box>
        ))
    } </box>
}

// CENTER 
function FocusedClient(): JSX.Element {
    const client = bind(hyprland, "focusedClient");
    return <box
        className="FocusedClient"
        visible={client.as(Boolean)}
    >
        <label label={client.as(c => c ? c.title : "")} />
    </box>
}

function Time(): JSX.Element {
    return <box
        className="DateTime"
    >
        <centerbox className="Icon">
            <label label="" />
        </centerbox>
        <box
            spacing={6}
            className="Values"
        >
            <label label={bind(time)} className="Time" />
            <label label={bind(day)} className="Day" />
        </box>
    </box>
}

// RIGHT
function Volume(): JSX.Element {
    return <box className="Volume">
        <box className="Icon">
            <icon icon={bind(speaker, "volume_icon")} />
        </box>
        <box className="Value">
            <label label={bind(speaker, "volume").as(v => Math.round(v * 100) + "%")} />
        </box>
    </box>
}

function BatteryIcon() {
    return battery.percentage < 0.25 ? "" :
           battery.percentage < 0.75  ? "" :
           battery.percentage < 0.90 ? "" :
           "";
}

function Power(): JSX.Element {
    return <box className="Power">
        <box className="Icon"> {
            bind(battery, "charging").as(charging => charging ?
                (<label label="" />) :
                (<label label={bind(battery, "percentage").as(v => BatteryIcon())} />)
        )} </box>
        <box className="Value">
            <label label={bind(battery, "percentage").as(v => Math.round(v * 100) + "%")} />
        </box>
    </box>
}

function SysTray(): JSX.Element {
    return <box className="Tray">
        <button
            className="TrayToggle"
            cursor="pointer"
            onClick={() => tray_open.set(!tray_open.get()) }
        >
            <label label={bind(tray_open).as(v => v ? ">" : "<")} />
        </button>
        <revealer
            revealChild={bind(tray_open)}
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
                            actionGroup={bind(item, "actionGroup").as(ag => [ "dbusmenu", ag ])}
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
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}
    >
        <box>
            <box hexpand halign={Gtk.Align.START} className="LeftBox">
                <Dashboard />
                <Workspaces />
            </box>
            <box hexpand halign={Gtk.Align.CENTER} className="CenterBox">
                <Time />
            </box>
            <box hexpand halign={Gtk.Align.END} className="RightBox">
                <Volume />
                <Power />
                <SysTray />
            </box>
        </box>
    </window>
}
