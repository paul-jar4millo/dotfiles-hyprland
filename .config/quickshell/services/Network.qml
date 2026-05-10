pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Networking

Singleton {
    id: root


    property var activeDevice: null

    Timer {
        interval: 50
        running: true
        repeat: true
        onTriggered: {
            if (!Networking.devices || !Networking.devices.values) return;
            var devs = Networking.devices.values;
            var found = null;
            for (var i = 0; i < devs.length; i++) {
                if (devs[i].connected) {
                    found = devs[i];
                    break;
                }
            }
            root.activeDevice = found;
        }
    }

    readonly property url icon: {
        if (!activeDevice) return Qt.resolvedUrl("../assets/icons/wifi-off.svg")
        if (activeDevice.type === DeviceType.Wired) {
            return Qt.resolvedUrl("../assets/icons/ethernet.svg")
        }
        return Qt.resolvedUrl("../assets/icons/wifi.svg")
    }
    
    readonly property string text: {
        if (!activeDevice) return ""
        return activeDevice.name
    }

}
