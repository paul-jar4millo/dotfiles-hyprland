pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    readonly property var items: Hyprland.workspaces
    readonly property var active: Hyprland.focusedWorkspace
}
