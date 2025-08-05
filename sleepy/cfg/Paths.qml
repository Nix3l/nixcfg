pragma Singleton

import Quickshell
import Qt.labs.platform

Singleton {
    id: root;

    property string home: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0];
    property string config: `${home}/.config/sleepy`;
    property string configFile: `${config}/cfg.json`;
}
