import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, exec } from "astal"

import { Calendar, LevelBar, Spinner } from "../util/utils"
import { mem_usage, mem_usage_abbr, max_ram, cpu_usage } from "../util/stats"

import Network from "gi://AstalNetwork"
import Bluetooth from "gi://AstalBluetooth"
import Battery from "gi://AstalBattery"

enum SettingsTypes {
    Mixer = 0,
    Calendar = 1,
}

let selected_setting = Variable(SettingsTypes.Mixer);

const network = Network.get_default();
const bluetooth = Bluetooth.get_default();
const adapter: Bluetooth.Adapter = bluetooth.adapter;

const battery = Battery.get_default();

const max_brightness = Number(exec(`bash -c 'brightnessctl m'`));

// CALENDAR MODULE
function CalendarModule(): JSX.Element {
    return <box
        vexpand
        hexpand
        vertical
        className="CalendarModule"
    >
        <Calendar 
            halign={Gtk.Align.FILL}
            valign={Gtk.Align.FILL}
            showDetails={false}
            showHeading
            showDayNames
            className="Calendar"
        />
    </box>
}

// MIXER MODULE
function BatteryIcon() {
    return battery.percentage < 0.25 ? "" :
           battery.percentage < 0.75  ? "" :
           battery.percentage < 1.00 ? "" :
           "";
}

function NetworkIcon(input: string): string {
    if(input.includes("signal-excellent")) return "./assets/wifi-good.svg";
    if(input.includes("signal-ok")) return "./assets/wifi-ok.svg";
    if(input.includes("signal-weak")) return "./assets/wifi-weak.svg";

    return "./assets/wifi-none.svg";
}

function GetBrightness(): number {
    return Number(exec(`bash -c 'brightnessctl g'`));
}

function SetBrightness(brightness: number): number {
    return Number(exec(`bash -c 'brightnessctl s ${brightness}'`));
}

function NetworkStatus(): JSX.Element {
    let ap = bind(network.wifi, "active_access_point");
    return <stack
        hexpand
        visibleChildName={ap.as(ap => ap ? "on" : "off")}
    >
        <box
            hexpand
            spacing={12}
            name="on"
            className="Network"
        > 
            <icon icon={bind(network.wifi.active_access_point, "icon_name").as(name => NetworkIcon(name))}/>
            <box
                vertical
                hexpand
                halign={Gtk.Align.START}
                valign={Gtk.Align.CENTER}
            >
                <label
                    label={ap.as(ap => ap.ssid)}
                    halign={Gtk.Align.START}
                    className="Name"
                />
                <label
                    label={
                        bind(network.wifi, "internet").as(internet =>
                            internet != Network.Internet.CONNECTED ?
                                "Connected, No Internet" : "Connected"
                    )}
                    halign={Gtk.Align.START}
                    className="Status"
                />
            </box>
        </box>
        <box
            hexpand
            spacing={12}
            name="off"
            className="Network"
        >
            <icon icon={NetworkIcon("signal-none")} />
            <box
                vertical
                hexpand
                halign={Gtk.Align.START}
                valign={Gtk.Align.CENTER}
            >
                <label
                    label="---"
                    halign={Gtk.Align.START}
                    className="Name"
                />
                <label
                    label="Disconnected"
                    halign={Gtk.Align.START}
                    className="Status"
                />
            </box>
        </box>
    </stack>
}

function BluetoothStatus(): JSX.Element {
    if(!adapter.discovering && bluetooth.is_powered) adapter.start_discovery();
    let paired_device = bind(bluetooth, "devices").as(list => list
            .filter((device) => device.paired && device.name != null)
            .find((device) => device.connected));

    return <stack
        hexpand
        visibleChildName={bind(bluetooth, "is_powered").as(powered => powered ? "on" : "off")}
    >
        <box
            name="on"
            hexpand
            spacing={12}
            className="Bluetooth"
        >
            <label label="" />
            <box
                vertical
                hexpand
            >
                <label
                    halign={Gtk.Align.START}
                    label={paired_device.as((device) => device ? device.name : "No Device")}
                    className="Name"
                />
                <label
                    halign={Gtk.Align.START}
                    label={paired_device.as((device) => device ? "Paired, Connected" : "Connect to a Device to see its status")}
                    className="Status"
                />
            </box>
        </box>
        <box
            name="off"
            hexpand
            spacing={12}
            className="Bluetooth"
        >
            <label label="" />
            <box
                vertical
                hexpand
            >
                <label
                    halign={Gtk.Align.START}
                    label="Disabled"
                    className="Name"
                />
                <label
                    halign={Gtk.Align.START}
                    label="Connect to Bluetooth to see its status"
                    className="Status"
                />
            </box>
        </box>
    </stack>
}

// TODO: change from vertical => horizontal boxes to horizontal => vertical boxes for ideal widths
function MixerModule(): JSX.Element {
    return <box
        vertical
        hexpand
        spacing={12}
        className="MixerModule"
    >
        <box
            hexpand
            spacing={12}
        >
            <box
                vertical
                halign={Gtk.Align.START}
                spacing={12}
                className={"Icons"}
            >
                <label label={bind(battery, "charging").as(charging => charging ? "" : BatteryIcon())} className="icon" />
                <label label="" className="icon" />
                <label label="" className="icon" />
            </box>
            <box
                vertical
                hexpand
                spacing={12}
                className={"Bars"}
            >
                <LevelBar
                    hexpand
                    heightRequest={24}
                    min_value={0}
                    max_value={1} 
                    value={bind(battery, "percentage")} 
                    className="Battery"
                />
                <LevelBar
                    hexpand
                    heightRequest={24}
                    min_value={0}
                    max_value={1}
                    value={bind(mem_usage).as(mem => mem / max_ram)}
                    className="Memory"
                />
                <LevelBar
                    hexpand
                    heightRequest={24}
                    min_value={0}
                    max_value={1}
                    value={bind(cpu_usage).as(usage => usage)}
                    className="Cpu"
                />
            </box>
            <box
                vertical
                halign={Gtk.Align.END}
                spacing={12}
                className={"Values"}
            >
                <label
                    label={bind(battery, "percentage").as(full => (full * 100) + "%")}
                    halign={Gtk.Align.START}
                    className="value"
                />
                <label
                    label={bind(mem_usage_abbr)}
                    halign={Gtk.Align.START}
                    className="value"
                />
                <label 
                    label={bind(cpu_usage).as(usage => (usage * 100).toPrecision(3) + "%")}
                    halign={Gtk.Align.START}
                    className="value"
                />
            </box>
        </box>
        <NetworkStatus />
        <BluetoothStatus />
        <box
            hexpand
            className="Brightness"
        >
            <label label="" />
            <slider
                hexpand
                drawValue={false}
                cursor="pointer"
                value={GetBrightness() / max_brightness}
                onDragged={(self) => SetBrightness((0.1 + self.value * 0.9) * max_brightness)}
            />
        </box>
    </box>
}

function SettingsButton({ type, label }: { type: SettingsTypes; label: string }): JSX.Element {
    return <button
                onClick={() => selected_setting.set(type)}
                className={bind(selected_setting).as(s => s == type ? "SelectedButton" : "")}
            >
            <label label={label} />
        </button>
}

// yes i only remembered halfway through writing this that stacks exist
// no i do not care enough to switch
export function SettingsModule(): JSX.Element {
    return <box
        vertical
        vexpand
        widthRequest={400}
        className="SettingsModule"
    >
        <box
            spacing={8}
            className="SettingsList"
        >
            <SettingsButton type={SettingsTypes.Mixer} label="" />
            <SettingsButton type={SettingsTypes.Calendar} label="" />
        </box> {
            bind(selected_setting).as(setting =>
                setting == SettingsTypes.Mixer ?
                    (<MixerModule />) :
                setting == SettingsTypes.Calendar ?
                    (<CalendarModule />) :
                (<label label="error?? noway!" />)
            )
        }
    </box>
}
