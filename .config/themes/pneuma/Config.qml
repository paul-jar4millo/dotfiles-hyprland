// Furina — pneuma
pragma Singleton
import QtQuick
import Quickshell
Singleton {
    id: root
    readonly property color primary: "#3854A9"
    readonly property color secondary: "#a9b0b9ff"
    readonly property color accent: "#82B1FF"
    readonly property color text: "#FFFFFF"
    readonly property color textMuted: "#AEC4FF"
    readonly property color border: "#82B1FF"
    readonly property color bg: "#E8F5FE"
    readonly property color bgFg: "#183B75"
    readonly property color surface: "#DCE9F2"
    readonly property color surfaceFg: "#183B75"
    readonly property color primaryColor: "#7586D5"
    readonly property color primaryFg: "#FFFFFF"
    readonly property color secondaryColor: "#717DB9"
    readonly property color tertiaryColor: "#4D5B99"
    readonly property color errorColor: "#D32F2F"
    readonly property real backgroundOpacity: 0.80
    readonly property int fontWeight: Font.DemiBold
}
