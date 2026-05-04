pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    // Colors
    readonly property color primary: "#161f8a"
    readonly property color secondary: "#4a68e2"
    readonly property color accent: "#fbddc3"
    readonly property color text: "#fbddc3"
    readonly property color textMuted: "#a6adc8"
    readonly property color border: "#45475a"

    // Opacity
    readonly property real backgroundOpacity: 0.80

    // Typography
    readonly property int fontWeight: Font.DemiBold
}
