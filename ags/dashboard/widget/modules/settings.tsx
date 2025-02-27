import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, exec } from "astal"

import { Calendar, LevelBar, Spinner } from "../util/utils"
import { mem_usage, mem_usage_abbr, max_ram, cpu_usage } from "../util/stats"

import Network from "gi://AstalNetwork"
import Bluetooth from "gi://AstalBluetooth"
import Battery from "gi://AstalBattery"

enum SettingsTypes {
    Mixer = 0,
    Network = 1,
    Bluetooth = 2,
    Calendar = 3,
}

let selected_setting = Variable(SettingsTypes.Network);

// NETWORK MODULE
const network = Network.get_default();
let primary = bind(network, "primary");
let state = bind(network, "state");

let wifi: Network.Wifi = network.wifi;
let wired: Network.Wired = network.wired;

let access_points = bind(wifi, "access_points").as(list => FilterNetworks(list));

function FilterNetworks(list: Network.AccessPoint[]): Network.AccessPoint[] {
    let found: string[] = [];
    return list.sort((a, b) => b.strength - a.strength)
    .filter((ap) => {
        if(found.includes(ap.ssid)) {
            return false;
        } else {
            found.push(ap.ssid);
            return true;
        }
    });
}

function NetworkIcon(input: string): string {
    if(input.includes("signal-strong")) return "./assets/wifi-good.svg";
    if(input.includes("signal-ok")) return "./assets/wifi-ok.svg";
    if(input.includes("signal-weak")) return "./assets/wifi-weak.svg";

    return "./assets/wifi-none.svg";
}

function NetworkAccessPoint({ ap } : { ap: Network.AccessPoint }): JSX.Element {
    return <box
        heightRequest={28}
        className={bind(wifi, "active_access_point").as(active =>
            active.ssid == ap.ssid ? "ActiveAccessPoint" : "AccessPoint"
        )}
    >
        <icon valign={Gtk.Align.CENTER} icon={bind(ap, "icon_name").as(name => NetworkIcon(name))} />
        <label halign={Gtk.Align.START} label={bind(ap, "ssid").get()} className="ssid" />
        <box
            hexpand
            halign={Gtk.Align.END}
        >
            <button
                cursor="pointer"
                onClick={() => exec(`bash -c 'nmcli c ${ap.ssid}'`)}
                className="ConnectionToggle"
            >
                <label label={bind(wifi, "active_access_point").as(active =>
                    active.ssid === ap.ssid ? "" : ""
                )} />
            </button>
        </box>
    </box>
}

function NetworkWifiContents(): JSX.Element {
    return <scrollable
        hscroll={Gtk.PolicyType.NEVER}
        className="Contents"
    >
        <box
            vertical
            hexpand
            vexpand
            spacing={12}
        > {
            access_points.as(list => list
                .sort((a, b) => b.strength - a.strength)
                .map(ap =>
                    (<NetworkAccessPoint ap={ap} />)
            ))
        } </box>
    </scrollable>
}

function NetworkModule(): JSX.Element {
    primary = bind(network, "primary");
    state = bind(network, "state");

    wifi = network.get_wifi() as Network.Wifi;
    wired = network.get_wired() as Network.Wired;

    return <box
        vexpand
        hexpand
        className="NetworkModule"
    >
        <box
            vertical
            vexpand
            spacing={12}
            className="Sidebar"
        >
            <button
                onClick={() => {
                    if(network.primary == Network.Primary.WIFI)
                        network.primary = Network.Primary.WIRED;
                    else if(network.primary == Network.Primary.WIRED)
                        network.primary = Network.Primary.WIFI
                }}
                className="Switcher"
            >
                <label label={primary.as(p =>
                    p == Network.Primary.WIRED ? "" :
                    p == Network.Primary.WIFI  ? "" :
                    "")
                } />
            </button>
            <button
                onClick={() => wifi.scan()}
                className="Reload"
            >
                <label label="" className={
                    bind(wifi, "scanning").as(spinning => spinning ? "Spin" : "")
                }/>
            </button>
            <button
                onClick={() => {
                    for(let ap of wifi.access_points) {
                        print(ap.ssid + " " + ap.strength + " " + ap.frequency + " " + ap.bssid); 
                    }
                }}
            >
                <label label="d" />
            </button>
        </box>
        {
            primary.as(p =>
                p == Network.Primary.WIRED ?
                    (<label label="wired" />) :
                p == Network.Primary.WIFI ?
                    (<NetworkWifiContents />) :
                    (<label label="idk" />)
                )
        } 
    </box>
}

// BLUETOOTH MODULE
const bluetooth = Bluetooth.get_default();
const adapter: Bluetooth.Adapter = bluetooth.adapter;

let show_paired_devices = Variable(true);
let show_unpaired_devices = Variable(false);

function PairedDevice({ device }: { device: Bluetooth.Device }): JSX.Element {
    return <box
        hexpand
        className="PairedDevice"
    >
        <icon halign={Gtk.Align.START} icon={bind(device, "icon")} />
        <label halign={Gtk.Align.START} label={bind(device, "name")} />
        <button
            halign={Gtk.Align.END}
            onClick={() => device.cancel_pairing()}
            className="PairToggle"
        >
            <label label="" />
        </button>
        <button
            halign={Gtk.Align.END}
            onClick={() => {
                if(device.connected)
                    device.disconnect_device();
                else
                    device.connect_device();
            }}
            className="ConnectionToggle"
        >
            <label label={bind(device, "connecting").as(connecting => connecting ?
                "" :
                device.connected ? "" : ""
            )} />
        </button>
    </box>
}

function UnPairedDevice({ device }: { device: Bluetooth.Device }): JSX.Element {
    return <box
        hexpand
        className="UnPairedDevice"
    >
        <icon halign={Gtk.Align.START} icon={bind(device, "icon")} />
        <label halign={Gtk.Align.START} label={bind(device, "name")} />
        <box halign={Gtk.Align.END}>
            <button
                halign={Gtk.Align.END}
                onClick={() => device.pair()}
                className="PairToggle"
            >
                <label label={bind(device, "connecting").as(connecting => connecting ?
                    "" : ""
                )} />
            </button>
        </box>
    </box>
}

function BluetoothModule(): JSX.Element {
    return <box
        vexpand
        hexpand
        spacing={12}
        className={
            bind(bluetooth, "is_powered").as(powered => powered ?
                "BluetoothModule" : "BluetoothModuleDisabled"
            )
        }
    >
        <box
            vertical
            vexpand
            spacing={12}
            className="Sidebar"
        >
            <button
                onClick={() => bluetooth.toggle()}
            >
                <label label={
                    bind(bluetooth, "is_powered").as(powered => powered ?
                        "" : ""
                    )
                } />
            </button>
            <button
                onClick={() => {
                    if(!bluetooth.is_powered) return;
                    if(adapter.discovering)
                        adapter.stop_discovery();
                    else
                        adapter.start_discovery();
                }}
            >
                <label label={
                    bind(adapter, "discovering").as(discovering => discovering ?
                        "" : ""
                    )
                } />
            </button>
            <button
                onClick={() => {
                    for(let device of bluetooth.devices)
                        print(device.name + " " + device.alias + " " + device.paired + " " + device.connected);
                }}
            >
                <label label="d" />
            </button>
        </box>
        <box
            vertical
            vexpand
            hexpand
            spacing={12}
            className="Devices"
        >
            <box hexpand>
                <label label="Paired Devices" />
                <button
                    onClick={() => show_paired_devices.set(!show_paired_devices.get())}
                    className="SectionRevealButton"
                >
                    <label label={bind(show_paired_devices).as(show => show ?
                        "" : ""
                    )} />
                </button>
            </box>
            <revealer
                revealChild={bind(show_paired_devices)}
                transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
            >
                <box
                    vertical
                    hexpand
                    spacing={12}
                    className="PairedDevices"
                >
                    <label
                        visible={bind(bluetooth, "devices").as(list => list
                            .filter((device) => device.paired && device.name != null)
                            .length == 0)
                        }
                        label="No Devices Paired"
                    />
                    {
                        bind(bluetooth, "devices").as(list => list
                            .filter((device) => device.paired && device.name != null)
                            .map((device) => (<PairedDevice device={device} />))
                        )
                    }
                </box>
            </revealer>
            <box hexpand>
                <label label="Available Devices" />
                <button
                    onClick={() => show_unpaired_devices.set(!show_unpaired_devices.get())}
                    className="SectionRevealButton"
                >
                    <label label={bind(show_unpaired_devices).as(show => show ?
                        "" : ""
                    )} />
                </button>
            </box>
            <revealer
                revealChild={bind(show_unpaired_devices)}
                transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
            >
                <box
                    vertical
                    hexpand
                    spacing={12}
                    className="UnPairedDevices"
                >
                    <label
                        visible={bind(bluetooth, "devices").as(list => list
                            .filter((device) => device.paired && device.name != null)
                            .length == 0)
                        }
                        label="No Devices Found"
                    />
                    {
                        bind(bluetooth, "devices").as(list => list
                            .filter((device) => !device.paired && device.name != null)
                            .map((device) => (<UnPairedDevice device={device} />))
                        )
                    }
                </box>
            </revealer>
        </box>
    </box>
}

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
const battery = Battery.get_default();

function BatteryIcon() {
    return  battery.percentage < 0.25 ? "" :
            battery.percentage < 0.75  ? "" :
            battery.percentage < 1.00 ? "" :
            "";
}

// TODO: change from vertical => horizontal boxes to horizontal => vertical boxes for ideal widths
function MixerModule(): JSX.Element {
    return <box
        hexpand
        spacing={12}
        className="MixerModule"
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
                label={
                    bind(battery, "percentage").as(full => (full * 100) + "%")
                }
                halign={Gtk.Align.START}
                className="value"
            />
            <label
                label={
                    bind(mem_usage_abbr)
                }
                halign={Gtk.Align.START}
                className="value"
            />
            <label 
                label={
                    bind(cpu_usage).as(usage =>
                        (usage * 100).toPrecision(3) + "%"
                    )
                }
                halign={Gtk.Align.START}
                className="value"
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
            <SettingsButton type={SettingsTypes.Network} label="" />
            <SettingsButton type={SettingsTypes.Bluetooth} label="" />
            <SettingsButton type={SettingsTypes.Calendar} label="" />
            <SettingsButton type={SettingsTypes.Mixer} label="" />
        </box> {
            bind(selected_setting).as(setting =>
                setting == SettingsTypes.Network ?
                    (<NetworkModule />) :
                setting == SettingsTypes.Bluetooth ?
                    (<BluetoothModule />) :
                setting == SettingsTypes.Calendar ?
                    (<CalendarModule />) :
                setting == SettingsTypes.Mixer ?
                    (<MixerModule />) :
                (<label label="error?? noway!" />)
            )
        }
    </box>
}
