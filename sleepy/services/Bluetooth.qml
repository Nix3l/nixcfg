pragma Singleton

import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root;

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter;

    readonly property bool enabling: adapter?.state == BluetoothAdapterState.Enabling ?? false;
    readonly property bool disabling: adapter?.state == BluetoothAdapterState.Disabling ?? false;
    readonly property bool occupied: enabling || disabling;
    readonly property bool discovering: adapter?.discovering ?? false;

    readonly property list<BluetoothDevice> devices: adapter?.devices.values
        .filter((d) => d.deviceName != "") // filter out the weird stuff that comes up when discovering
        .sort((a,b) => (b.bonded + b.paired + b.connected) - (a.bonded + a.paired + a.connected))
        ?? [];

    readonly property list<BluetoothDevice> connectedDevices: devices.filter(d => d.connected);
    readonly property list<BluetoothDevice> pairedDevices: devices.filter(d => d.paired);
    readonly property BluetoothDevice connectedDevice: devices.filter(d => d.connected)[0] ?? null;

    readonly property bool enabled: adapter?.enabled ?? false;
    readonly property bool connected: connectedDevices.length > 0;
}
