import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import "."

Rectangle {
    id: barRoot
    
    property var screen
    property var window
    property bool barVisible: true
    readonly property bool animating: barAnim.running
    
    width: parent.width * Theme.barWidthMult
    height: Theme.barHeight
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: barVisible ? Theme.barTopMargin : -height - 10
    
    Behavior on anchors.topMargin {
        NumberAnimation {
            id: barAnim
            duration: 400
            easing.type: Easing.Bezier
            easing.bezierCurve: [1, 1.6, 0.1, 0.85, 1, 1]
        }
    }
    
    color: Theme.background
    
    topLeftRadius: Theme.barTopLeftRadius
    topRightRadius: Theme.barTopRightRadius
    bottomLeftRadius: Theme.barBottomLeftRadius
    bottomRightRadius: Theme.barBottomRightRadius
    
    border.color: Theme.barBorderColor
    border.width: Theme.barBorderWidth
    
    // Process instance for general commands
    Process { id: shellExec }

    // Left Section
    RowLayout {
        id: leftSection
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        spacing: 15
        
        // Logo / Launcher
        Loader {
            sourceComponent: Theme.logoSource !== "" ? logoImage : logoText
            
            Component {
                id: logoText
                Text {
                    text: Theme.logoText
                    font.pixelSize: 36
                    color: Theme.logoColor
                }
            }
            
            Component {
                id: logoImage
                Image {
                    source: Theme.logoSource
                    sourceSize.width: 36
                    sourceSize.height: 36
                    fillMode: Image.PreserveAspectFit
                }
            }
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    shellExec.command = ["sh", "-c", Theme.launcherCommand];
                    shellExec.startDetached();
                }
            }
        }
        
        Text {
            text: ""
            font.pixelSize: 24
            color: Theme.white
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    shellExec.command = ["sh", "-c", "rofi -show filebrowser &"];
                    shellExec.startDetached();
                }
            }
        }
        
        Text {
            text: "|"
            font.pixelSize: 22
            color: Theme.grey
            font.bold: true
        }
        
        Workspaces {
            screen: barRoot.screen
            MouseArea {
                acceptedButtons: Qt.NoButton
                onWheel: (wheel) => {
                    if (wheel.angleDelta.y > 0) {
                        Hyprland.dispatch(`hl.dsp.focus({ workspace = '-1' })`);
                    } else {
                        Hyprland.dispatch(`hl.dsp.focus({ workspace = '+1' })`);
                    }
                }
            }
        }
    }
    
    // Center Section - Truly Centered
    ActiveWindow {
        anchors.centerIn: parent
    }
    
    // Right Section
    RowLayout {
        id: rightSection
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        
        RowLayout {
            anchors.rightMargin: 15
            spacing: 0

            Brightness {}
            Volume {}
            Wifi {}
            SysTray { window: barRoot.window }
        }
        
        Text {
            text: "|"
            font.pixelSize: 22
            color: Theme.grey
            font.bold: true
        }
        
        SystemInfo {}
        
        Text {
            text: "|"
            font.pixelSize: 22
            color: Theme.grey
            font.bold: true
        }
        
        Clock {}
        
        Text {
            text: "󰍩"
            font.pixelSize: 28
            color: Theme.white
            
            MouseArea {
                anchors.fill: parent
                onClicked: barRoot.toggleNotifications()
            }
        }
    }
    
    signal toggleNotifications()
}
