pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string mode: "ousia"

    Process {
        command: ["cat", Quickshell.env("HOME") + "/.cache/furina-theme"]
        running: true
        stdout: SplitParser {
            onRead: (text) => {
                var theme = text.trim();
                if (root.themes[theme]) {
                    root.mode = theme;
                }
            }
        }
    }

    readonly property var themes: {
        "ousia": {
            "primary": "#22272A",
            "secondary": "#2C3236",
            "accent": "#343971",
            "text": "#C8CBD4",
            "textMuted": "#7F818D",
            "border": "#4A5055",
            "bg": "#161A1B",
            "bgFg": "#E0E1E5",
            "surface": "#22272A",
            "surfaceFg": "#C8CBD4",
            "primaryColor": "#343971",
            "primaryFg": "#FFFFFF",
            "secondaryColor": "#494F6F",
            "tertiaryColor": "#5C618A",
            "errorColor": "#F44336",
            "backgroundOpacity": 0.80,
            "fontWeight": Font.DemiBold
        },
        "pneuma": {
            "primary": "#3854A9",
            "secondary": "#a9b0b9ff",
            "accent": "#82B1FF",
            "text": "#FFFFFF",
            "textMuted": "#AEC4FF",
            "border": "#82B1FF",
            "bg": "#E8F5FE",
            "bgFg": "#183B75",
            "surface": "#DCE9F2",
            "surfaceFg": "#183B75",
            "primaryColor": "#7586D5",
            "primaryFg": "#FFFFFF",
            "secondaryColor": "#717DB9",
            "tertiaryColor": "#4D5B99",
            "errorColor": "#D32F2F",
            "backgroundOpacity": 0.80,
            "fontWeight": Font.DemiBold
        }
    }

    readonly property var active: themes[mode] 

    readonly property color primary: active.primary
    readonly property color secondary: active.secondary
    readonly property color accent: active.accent
    readonly property color text: active.text
    readonly property color textMuted: active.textMuted
    readonly property color border: active.border
    readonly property color bg: active.bg
    readonly property color bgFg: active.bgFg
    readonly property color surface: active.surface
    readonly property color surfaceFg: active.surfaceFg
    readonly property color primaryColor: active.primaryColor
    readonly property color primaryFg: active.primaryFg
    readonly property color secondaryColor: active.secondaryColor
    readonly property color tertiaryColor: active.tertiaryColor
    readonly property color errorColor: active.errorColor
    readonly property real backgroundOpacity: active.backgroundOpacity
    readonly property int fontWeight: active.fontWeight

    IpcHandler {
        target: "theme"
        function setTheme(name: string): void {
            if (root.themes[name]) {
                root.mode = name;
            }
        }
    }
}
