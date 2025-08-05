pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root;

    readonly property date date: sysclock.date;
    readonly property int seconds: sysclock.seconds;
    readonly property int minutes: sysclock.minutes;
    readonly property int hours: sysclock.hours;
    readonly property string weekday: format();

    function format(fmt: string): string {
        return date.toLocaleString(Qt.locale(), fmt);
    }

    SystemClock {
        id: sysclock;
        precision: SystemClock.seconds;
    }
}
