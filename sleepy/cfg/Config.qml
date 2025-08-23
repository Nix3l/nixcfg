pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root;

    property JsonObject modules: JsonObject {
        property bool bluetoothStatus: modulescfg.bluetoothStatus;
    }

    property JsonObject bar: JsonObject {
        property int height: barcfg.height;
        property int vpadding: barcfg.vpadding;
        property int hpadding: barcfg.hpadding;
        readonly property int contentHeight: height - vpadding * 2;
        property int numWorkspacesShown: barcfg.numWorkspacesShown;
    }

    property JsonObject timing: JsonObject {
        property int networkUpdate: timecfg.networkUpdate;
        property int brightnessUpdate: timecfg.brightnessUpdate;
        property int notifDisplayTimeout: timecfg.notifDisplayTimeout;
    }

    property JsonObject chooser: JsonObject {
        property int contentWidth: choosercfg.contentWidth;
        property int itemHeight: choosercfg.itemHeight;
        property int itemSpacing: choosercfg.itemSpacing;
        property int maxShownItems: choosercfg.maxShownItems;
        property int itemPadding: choosercfg.itemPadding;
        readonly property int contentHeight: itemHeight - itemPadding * 2;
        property int contentSpacing: choosercfg.contentSpacing;
        property int promptPadding: choosercfg.promptPadding;
        property int promptFontSize: choosercfg.promptFontSize;
        property int itemFontSize: choosercfg.itemFontSize;
    }

    property JsonObject applauncher: JsonObject {
        property bool showIcons: applaunchercfg.showIcons;
    }

    property JsonObject notifs: JsonObject {
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
            property JsonObject modules: JsonObject {
                id: modulescfg;

                property bool bluetoothStatus: false;
            }

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
                property int brightnessUpdate: 1000;
                property int notifDisplayTimeout: 2400;
            }

            property JsonObject chooser: JsonObject {
                id: choosercfg;

                property int contentWidth: 800;
                property int itemHeight: 64;
                property int itemSpacing: 8;
                property int maxShownItems: 6;

                property int itemPadding: 12;

                property int contentSpacing: 24;
                property int promptPadding: 24;

                property int promptFontSize: 18;
                property int itemFontSize: 22;
            }

            property JsonObject applauncher: JsonObject {
                id: applaunchercfg;

                property bool showIcons: true;
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
