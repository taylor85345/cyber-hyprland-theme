import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import Quickshell.Io
import "."

RowLayout {
    spacing: 15
    
    readonly property var battery: UPower.displayDevice

    // Battery
    MouseArea {
        id: batteryHover
        Layout.preferredWidth: batteryRow.implicitWidth
        Layout.preferredHeight: 30
        hoverEnabled: true
        
        RowLayout {
            id: batteryRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8
            
            CircularProgress {
                value: battery ? (battery.percentage <= 1 ? battery.percentage * 100 : battery.percentage) : 0
                color: Theme.green
                size: 30
                strokeWidth: 4
                Layout.alignment: Qt.AlignVCenter
            }
            
            Item {
                Layout.preferredWidth: batteryHover.containsMouse ? batteryText.implicitWidth : 0
                Layout.preferredHeight: batteryText.implicitHeight
                clip: true
                visible: Layout.preferredWidth > 0
                Layout.alignment: Qt.AlignVCenter
                
                Behavior on Layout.preferredWidth { NumberAnimation { duration: 200 } }

                Text {
                    id: batteryText
                    text: battery ? "Battery: " + Math.round(battery.percentage <= 1 ? battery.percentage * 100 : battery.percentage) + "%" : "N/A"
                    color: Theme.white
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
    
    // Memory
    MouseArea {
        id: memHover
        Layout.preferredWidth: memRow.implicitWidth
        Layout.preferredHeight: 30
        hoverEnabled: true
        
        property double percentage: 0
        property string usageText: "0 GB / 0 GB"

        FileView {
            id: meminfo
            path: "/proc/meminfo"
            onLoaded: {
                const data = text();
                const totalMatch = data.match(/MemTotal: *(\d+)/);
                const availMatch = data.match(/MemAvailable: *(\d+)/);
                if (totalMatch && availMatch) {
                    const totalKiB = parseInt(totalMatch[1], 10);
                    const availKiB = parseInt(availMatch[1], 10);
                    const usedKiB = totalKiB - availKiB;
                    
                    memHover.percentage = (usedKiB / totalKiB) * 100;
                    
                    const usedGB = (usedKiB / (1024 * 1024)).toFixed(1);
                    const totalGB = (totalKiB / (1024 * 1024)).toFixed(0);
                    memHover.usageText = usedGB + "GB of " + totalGB + "GB";
                }
            }
        }
        
        Timer {
            interval: 5000
            running: true
            repeat: true
            onTriggered: meminfo.reload()
        }

        RowLayout {
            id: memRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8
            
            CircularProgress {
                value: memHover.percentage
                color: Theme.orange
                size: 30
                strokeWidth: 4
                Layout.alignment: Qt.AlignVCenter
            }
            
            Item {
                Layout.preferredWidth: memHover.containsMouse ? memText.implicitWidth : 0
                Layout.preferredHeight: memText.implicitHeight
                clip: true
                visible: Layout.preferredWidth > 0
                Layout.alignment: Qt.AlignVCenter
                
                Behavior on Layout.preferredWidth { NumberAnimation { duration: 200 } }

                Text {
                    id: memText
                    text: memHover.usageText
                    color: Theme.white
                    font.pixelSize: 16
                    font.family: Theme.fontFamily
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
