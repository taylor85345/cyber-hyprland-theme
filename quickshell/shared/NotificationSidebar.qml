import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "."

PanelWindow {
    id: sidebar
    
    property bool active: false
    property var modelData
    
    signal hideRequested()
    
    visible: active || sidebarAnim.running
    
    anchors {
        top: true
        bottom: true
        right: true
    }
    
    // Standard overlay settings
    WlrLayershell.layer: WlrLayer.Top
    exclusiveZone: 0
    
    // Fixed width to eliminate Wayland resize jitter
    implicitWidth: Theme.sidebarWidth
    
    // Input mask follows the sliding container exactly
    mask: Region { item: container }
    
    color: "transparent"
    
    Rectangle {
        id: container
        width: parent.width - (Theme.sidebarWidth == parent.width ? 0 : 28)
        height: parent.height * Theme.sidebarHeightMult
        anchors.top: parent.top
        anchors.topMargin: Theme.sidebarTopMargin
        
        // Slide animation: 
        // 0 is the left edge of our window (visible)
        // sidebarWidth is the right edge of our window (off-screen)
        x: sidebar.active ? 0 : Theme.sidebarWidth
        Behavior on x { 
          NumberAnimation { 
            id: sidebarAnim
            duration: Theme.sidebarWidth; 
            easing.type: Easing.Bezier 
            easing.bezierCurve: [1, 1.6, 0.1, 0.85, 1, 1]
          } 
        }
        
        color: Theme.background
        
        topLeftRadius: Theme.sidebarTopLeftRadius
        bottomLeftRadius: Theme.sidebarBottomLeftRadius
        topRightRadius: Theme.sidebarTopRightRadius
        bottomRightRadius: Theme.sidebarBottomRightRadius
        
        border.color: Theme.sidebarBorderColor
        border.width: Theme.sidebarBorderWidth

        Timer {
            id: hideTimer
            interval: 500
            onTriggered: sidebar.hideRequested()
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: hideTimer.stop()
            onExited: if (sidebar.active) hideTimer.start()
            propagateComposedEvents: true
            onPressed: (mouse) => mouse.accepted = false
            onReleased: (mouse) => mouse.accepted = false
            onClicked: (mouse) => mouse.accepted = false
        }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20
            
            RowLayout {
                Layout.fillWidth: true
                Text {
                    id: title
                    text: "Notifications"
                    color: Theme.sidebarTitleColor
                    font.pixelSize: 24
                    font.family: Theme.fontFamily
                    font.bold: true
                }
                
                Item { Layout.fillWidth: true }
                
                Text {
                    text: "󰎟"
                    color: Theme.red
                    font.pixelSize: 24
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            clearHistory.running = true;
                        }
                    }
                }
            }
            
            Notifications {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
    
    Process {
        id: clearHistory
        command: ["dunstctl", "history-clear"]
    }
}
