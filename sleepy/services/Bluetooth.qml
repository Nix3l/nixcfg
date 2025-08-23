pragma Singleton

import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root;

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter;
    readonly property list<BluetoothDevice> devices: adapter.devices.values;
    readonly property BluetoothDevice connectedDevice: devices.filter(d => d.connected)[0] ?? null;

    readonly property bool enabled: adapter.enabled;
    readonly property bool connected: devices.filter(d => d.connected).length > 0;
}
