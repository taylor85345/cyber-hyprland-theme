import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "."

RowLayout {
    spacing: 10
    
    id: trayRoot
    property bool tray_rev: false
    property var window
    
    Item {
        id: trayReveal
        Layout.preferredWidth: 30 + (trayIcons.Layout.preferredWidth > 0 ? trayIcons.Layout.preferredWidth + 10 : 0)
        Layout.preferredHeight: 48

        HoverHandler {
            onHoveredChanged: {
                if (hovered) {
                    closeTimer.stop();
                    trayRoot.tray_rev = true;
                } else {
                    closeTimer.start();
                }
            }
        }
        
        Timer {
            id: closeTimer
            interval: 500
            onTriggered: trayRoot.tray_rev = false
        }

        RowLayout {
            anchors.fill: parent
            spacing: 10

            Text {
                text: "󰅂"
                font.pixelSize: 35
                color: Theme.blue
                Layout.alignment: Qt.AlignVCenter
            }

            RowLayout {
                id: trayIcons
                spacing: 10
                Layout.preferredWidth: trayRoot.tray_rev ? implicitWidth : 0
                clip: true

                Repeater {
                    model: SystemTray.items
                    
                    delegate: MouseArea {
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        
                        IconImage {
                            anchors.fill: parent
                            source: modelData.icon
                        }
                        
                        onClicked: (mouse) => {
                            if (mouse.button === Qt.RightButton) {
                                const pos = mapToItem(barWindow.contentItem, width, height);
                                modelData.display(barWindow, pos.x, pos.y);
                            } else if (mouse.button === Qt.LeftButton) {
                                modelData.activate();
                            }
                        }
                    }
                }
                Behavior on Layout.preferredWidth { NumberAnimation { duration: 100 } }
            }
        }
    }
}
