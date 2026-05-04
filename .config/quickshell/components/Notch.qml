import QtQuick
import Quickshell
import "../services"

Item {
    id: notchRoot
    // Will require an item
    default required property Item item

    // Size will depend on the items content
    implicitWidth: item ? item.implicitWidth + 40 : 30
    height: 30

    // Anchor to the top of the screens
    anchors.top: parent ? parent.top : undefined

    Rectangle {
        anchors.fill: parent
        color: Config.primary
        opacity: Config.backgroundOpacity

        radius: 15
    }

    onItemChanged: {
        if (item) {
            item.parent = notchRoot;
            item.anchors.centerIn = notchRoot;
        }
    }
}
