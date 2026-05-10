pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property url icon: {
        if (!UPower.displayDevice) return Qt.resolvedUrl("../assets/icons/battery-low.svg")
        if (UPower.displayDevice.iconName.indexOf("charging") !== -1) return Qt.resolvedUrl("../assets/icons/battery-charging.svg")
        var p = UPower.displayDevice.percentage;
        if (p < 25) return Qt.resolvedUrl("../assets/icons/battery-low.svg")
        if (p < 75) return Qt.resolvedUrl("../assets/icons/battery-half.svg")
        return Qt.resolvedUrl("../assets/icons/battery-full.svg")
    }
    readonly property string percentage: UPower.displayDevice ? Math.round(UPower.displayDevice.percentage) + "%" : "0%"
    readonly property bool isPresent: UPower.displayDevice ? UPower.displayDevice.isPresent : false
}
