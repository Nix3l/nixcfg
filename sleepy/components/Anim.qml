import QtQuick

import "root:/cfg"
import "root:/style"

NumberAnimation {
    duration: Style.anim.durations.normal;
    easing.type: Easing.BezierSpline;
    easing.bezierCurve: Style.anim.curves.standard;
}
