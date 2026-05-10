import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Qt5Compat.GraphicalEffects
import "../components"
import "../services"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            // Multiple screen
            property var modelData
            screen: modelData

            // Anchor to the top
            anchors {
                top: true
                left: true
                right: true
            }
            margins.top: 8
            margins.left: 10
            margins.right: 10

            implicitHeight: 40

            // The bar itself is transparent, but notch aren't
            color: "transparent"

            // Left modules
            Row {
                id: leftModules
                anchors.left: parent.left
                anchors.top: parent.top
                spacing: 10

                // Workspaces
                Notch {
                    Row {
                        spacing: 8

                        Repeater {
                            model: Workspaces.items

                            Rectangle {
                                width: 30
                                height: 30
                                radius: 15

                                color: modelData === Workspaces.active ? Config.accent : Config.secondary

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.id
                                    font.weight: Config.fontWeight
                                    font.pixelSize: 14
                                    color: modelData === Workspaces.active ? Config.primaryFg : Config.text
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Hyprland.dispatch("workspace " + modelData.id)
                                }
                            }
                        }
                    }
                }

                // Programs
                Notch {
                    visible: windowsRepeater.count > 0
                    Row {
                        spacing: 8

                        Repeater {
                            id: windowsRepeater
                            model: Windows.items

                            IconImage {
                                source: Quickshell.iconPath(modelData.appId)
                                width: 24
                                height: 24

                                opacity: modelData.activated ? 1.0 : 0.5

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: modelData.activate()
                                }
                            }
                        }
                    }
                }
            }

            // Center modules
            Row {
                id: centerModules
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                spacing: 10

                // Clock
                Notch {
                    Text {
                        font.weight: Config.fontWeight
                        font.pixelSize: 15
                        color: Config.text
                        text: Time.time
                    }
                }

                
            }

            // Right modules
            Row {
                id: rightModules
                anchors.right: parent.right
                anchors.top: parent.top
                spacing: 10

                
                // System Tray
                Notch {
                    visible: trayRepeater.count > 0
                    Row {
                        spacing: 8

                        Repeater {
                            id: trayRepeater
                            model: SystemTray.items

                            IconImage {
                                id: trayIcon
                                source: modelData.icon
                                width: 24
                                height: 24

                                QsMenuAnchor {
                                    id: menuAnchor
                                    anchor.window: barWindow
                                    anchor.rect.x: trayIcon.mapToItem(null, 0, 0).x
                                    anchor.rect.y: trayIcon.mapToItem(null, 0, 0).y + trayIcon.height
                                    menu: modelData.menu
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.AllButtons
                                    onClicked: (mouse)=> {
                                        if (mouse.button == Qt.LeftButton) {
                                            modelData.activate();
                                        } else {
                                            if (modelData.menu) {
                                                menuAnchor.open();
                                            } else {
                                                var pos = trayIcon.mapToItem(null, 0, trayIcon.height);
                                                modelData.display(barWindow, pos.x, pos.y);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                

                // Services
                Notch {
                    Row {
                        spacing: 12

                        // Volume
                        Row {
                            spacing: 4
                            Item {
                                width: 18
                                height: 18
                                anchors.verticalCenter: parent.verticalCenter
                                IconImage {
                                    id: volumeIcon
                                    source: Volume.icon
                                    anchors.fill: parent
                                    visible: false
                                }
                                ColorOverlay {
                                    anchors.fill: volumeIcon
                                    source: volumeIcon
                                    color: Config.text
                                }
                            }
                            Text {
                                text: Volume.percentage
                                font.weight: Config.fontWeight
                                font.pixelSize: 14
                                color: Config.text
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // Internet
                        Row {
                            spacing: 4
                            Item {
                                width: 18
                                height: 18
                                anchors.verticalCenter: parent.verticalCenter
                                IconImage {
                                    id: networkIcon
                                    source: Network.icon
                                    anchors.fill: parent
                                    visible: false
                                }
                                ColorOverlay {
                                    anchors.fill: networkIcon
                                    source: networkIcon
                                    color: Config.text
                                }
                            }
                            Text {
                                text: Network.text
                                font.weight: Config.fontWeight
                                font.pixelSize: 14
                                color: Config.text
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // Battery
                        Row {
                            visible: Battery.isPresent
                            spacing: 4
                            Item {
                                width: 18
                                height: 18
                                anchors.verticalCenter: parent.verticalCenter
                                IconImage {
                                    id: batteryIcon
                                    source: Battery.icon
                                    anchors.fill: parent
                                    visible: false
                                }
                                ColorOverlay {
                                    anchors.fill: batteryIcon
                                    source: batteryIcon
                                    color: Config.text
                                }
                            }
                            Text {
                                text: Battery.percentage
                                font.weight: Config.fontWeight
                                font.pixelSize: 14
                                color: Config.text
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }

                // Date
                Notch {
                    Text {
                        font.weight: Config.fontWeight
                        font.pixelSize: 15
                        color: Config.text
                        text: Date.date
                    }
                }

                
            }
        }
    }
}
