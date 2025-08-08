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

    function timeFromSeconds(val: real): list<int> {
        const minutes = Math.floor(Math.round(val) / 60);
        const seconds = Math.round(val - minutes * 60);
        return [minutes, seconds];
    }

    function paddedTimeStr(min: int, sec: int): string {
        let str = "";

        if(min < 10) str += "0";
        str += min;
        str += ":";
        if(sec < 10) str += "0";
        str += sec;

        return str;
    }
}
