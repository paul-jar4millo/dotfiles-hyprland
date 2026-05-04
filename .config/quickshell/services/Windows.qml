pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Wayland

Singleton {
    id: root

    readonly property var items: ToplevelManager.toplevels
}
