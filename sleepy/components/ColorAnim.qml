import QtQuick

import "root:/cfg"
import "root:/style"

ColorAnimation {
    duration: Style.anim.durations.normal;
    easing.type: Easing.BezierSpline;
    easing.bezierCurve: Style.anim.curves.standard;
}
