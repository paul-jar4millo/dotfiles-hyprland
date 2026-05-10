// Furina — ousia
pragma Singleton
import QtQuick
import Quickshell
Singleton {
    id: root
    readonly property color primary: "#22272A"
    readonly property color secondary: "#2C3236"
    readonly property color accent: "#343971"
    readonly property color text: "#C8CBD4"
    readonly property color textMuted: "#7F818D"
    readonly property color border: "#4A5055"
    readonly property color bg: "#161A1B"
    readonly property color bgFg: "#E0E1E5"
    readonly property color surface: "#22272A"
    readonly property color surfaceFg: "#C8CBD4"
    readonly property color primaryColor: "#343971"
    readonly property color primaryFg: "#FFFFFF"
    readonly property color secondaryColor: "#494F6F"
    readonly property color tertiaryColor: "#5C618A"
    readonly property color errorColor: "#F44336"
    readonly property real backgroundOpacity: 0.80
    readonly property int fontWeight: Font.DemiBold
}
