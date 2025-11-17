import Quickshell.Io

JsonObject {
    property int contentWidth: 800;
    property int itemHeight: 64;
    property int itemSpacing: 8;
    property int maxShownItems: 6;

    property int itemPadding: 12;

    property int contentSpacing: 24;
    property int promptPadding: 24;

    property int promptFontSize: 18;
    property int itemFontSize: 22;

    readonly property int contentHeight: itemHeight - itemPadding * 2;
}
