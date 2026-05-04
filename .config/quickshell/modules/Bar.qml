import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import "../components"
import "../services"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
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

            implicitHeight: 30

            // The bar itself is transparent, but notch aren't
            color: "transparent"

            // ---------------------- Modular Layout -------------------------

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
                                width: 24
                                height: 24
                                radius: 12

                                color: modelData === Workspaces.active ? Config.accent : Config.secondary

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.id
                                    font.weight: Config.fontWeight
                                    color: modelData === Workspaces.active ? Config.primary : Config.text
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Hyprland.dispatch("workspace " + modelData.id)
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

                // Programs
                Notch {
                    Row {
                        spacing: 8

                        Repeater {
                            model: Windows.items

                            IconImage {
                                source: Quickshell.iconPath(modelData.appId)
                                width: 20
                                height: 20

                                opacity: modelData.activated ? 1.0 : 0.5

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: modelData.activate()
                                }
                            }
                        }
                    }
                }
                // Date
                Notch {
                    Text {
                        font.weight: Config.fontWeight
                        color: Config.text
                        text: Date.date
                    }
                }
            }
        }
    }
}
