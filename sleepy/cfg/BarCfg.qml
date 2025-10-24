import Quickshell.Io

JsonObject {
    property int height: 32;
    property int vpadding: 4;
    property int hpadding: 0;
    property int numWorkspacesShown: 4;
    readonly property int contentHeight: height - vpadding * 2;
}
