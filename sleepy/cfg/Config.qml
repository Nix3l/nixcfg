pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root;

    property QtObject bar;
    property QtObject drawer;
    property QtObject timing;
    property QtObject applauncher;
    property QtObject notifs;

    bar: QtObject {
        property int height: barcfg.height;
        property int vpadding: barcfg.vpadding;
        property int hpadding: barcfg.hpadding;
        readonly property int contentHeight: height - vpadding * 2;
        property int numWorkspacesShown: barcfg.numWorkspacesShown;
    }

    timing: QtObject {
        property int networkUpdate: timecfg.networkUpdate;
        property int notifDisplayTimeout: timecfg.notifDisplayTimeout;
    }

    applauncher: QtObject {
        property int width: applaunchercfg.width;
        property int height: applaunchercfg.height;
        property int border: applaunchercfg.border;
        property int padding: applaunchercfg.padding;
        property int spacing: applaunchercfg.spacing;

        property int promptHeight: applaunchercfg.promptHeight;
        property int itemHeight: applaunchercfg.itemHeight;
        readonly property int itemWidth: width - padding * 2;
    }

    notifs: QtObject {
        property bool placeRight: notifscfg.placeRight;
        property int width: notifscfg.width;
        property int minimumHeight: notifscfg.minimumHeight;
        property int border: notifscfg.border;
        property int padding: notifscfg.padding;
        property int margin: notifscfg.margin;
    }

    FileView {
        path: Paths.configFile;
        blockLoading: true;
        watchChanges: true;
        onFileChanged: reload();

        JsonAdapter {
            property JsonObject bar: JsonObject {
                id: barcfg;

                property int height: 28;
                property int vpadding: 4;
                property int hpadding: 0;
                property int numWorkspacesShown: 4;
            }

            property JsonObject timing: JsonObject {
                id: timecfg;

                property int networkUpdate: 1000;
                property int notifDisplayTimeout: 2400;
            }

            property JsonObject applauncher: JsonObject {
                id: applaunchercfg;

                property int width: 480;
                property int height: 320;
                property int border: 2;
                property int padding: 8;
                property int spacing: 8;
                property int promptHeight: 36;
                property int itemHeight: 38;
            }

            property JsonObject notifs: JsonObject {
                id: notifscfg;

                property bool placeRight: false; // TODO: this doesnt do anything at the moment
                property int width: 316;
                property int minimumHeight: 56;
                property int border: 1;
                property int padding: 8;
                property int margin: 8;
            }
        }
    }
}
