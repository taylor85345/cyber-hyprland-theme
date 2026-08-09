import QtQuick
import QtQuick.Layouts
import Quickshell
import "."

RowLayout {
    id: clockRoot
    spacing: 5
    
    property bool time_rev: false
    
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    
    MouseArea {
        Layout.preferredWidth: clockLayout.implicitWidth + 5
        Layout.preferredHeight: 30
        hoverEnabled: true
        onEntered: clockRoot.time_rev = true
        onExited: clockRoot.time_rev = false
        
        RowLayout {
            id: clockLayout
            anchors.verticalCenter: parent.verticalCenter
            spacing: clockRoot.time_rev ? 15 : 0
            
            Text {
                text: Qt.formatDateTime(clock.date, "h󰇙mm AP")
                color: Theme.white
                font.pixelSize: 28
                font.family: Theme.fontFamily
                font.bold: true
            }
            
            Item {
                Layout.preferredWidth: clockRoot.time_rev ? dateText.implicitWidth : 0
                Layout.preferredHeight: dateText.implicitHeight
                clip: true
                visible: Layout.preferredWidth > 0
                
                Behavior on Layout.preferredWidth { NumberAnimation { duration: 200 } }

                Text {
                    id: dateText
                    text: Qt.formatDateTime(clock.date, "MMM dd, yyyy")
                    color: Theme.red
                    font.pixelSize: 24
                    font.family: Theme.fontFamily
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
