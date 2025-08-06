import Quickshell
import Quickshell.Services.Notifications
import QtQuick

import "root:/cfg"

QtObject {
    id: root;

    required property Notification data;
    required property int displayTimeout;
    property bool hasImage: false;
    property string image: "";
    property string header: "";
    property string body: "";

    property bool display: true;

    readonly property Timer timer: Timer {
        running: root.displayTimeout > 0;
        interval: root.displayTimeout;
        onTriggered: {
            root.display = false;
        }
    }

    Component.onCompleted: {
        if(data.image != "") root.image = data.image;
        else if(data.appIcon != "") root.image = Quickshell.iconPath(data.appIcon);

        if(root.image != "") root.hasImage = true;

        if(data.summary != "") root.header = data.summary;
        else root.header = data.appName;

        root.body = data.body;
    }
}
