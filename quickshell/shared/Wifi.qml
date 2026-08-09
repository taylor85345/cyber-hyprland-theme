import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import "."

RowLayout {
    spacing: 5
    
    id: wifiRoot
    property bool wifi_rev: false
    property string essid: ""
    property string icon: "󰖪"
    
    Process {
        command: ["nmcli", "m"]
        running: true
        stdout: SplitParser {
            onRead: wifiUpdateProcess.running = true
        }
    }
    
    Process {
        id: wifiUpdateProcess
        command: ["nmcli", "-t", "-f", "active,ssid", "dev", "wifi"]
        running: true
        stdout: SplitParser {
            onRead: (line) => {
                if (line.startsWith("yes:")) {
                    wifiRoot.essid = line.split(":")[1];
                    wifiRoot.icon = "";
                }
            }
        }
    }
    
    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: wifiUpdateProcess.running = true
    }
    
    MouseArea {
        Layout.preferredWidth: 40 + (ssidContainer.Layout.preferredWidth > 0 ? ssidContainer.Layout.preferredWidth + 5 : 0)
        Layout.preferredHeight: 30
        hoverEnabled: true
        onEntered: wifiRoot.wifi_rev = true
        onExited: wifiRoot.wifi_rev = false
        
        RowLayout {
            anchors.fill: parent
            spacing: 5
            
            Item {
                id: ssidContainer
                Layout.preferredWidth: wifiRoot.wifi_rev && wifiRoot.essid !== "" ? ssidText.implicitWidth : 0
                Layout.preferredHeight: parent.height
                clip: true
                Behavior on Layout.preferredWidth { NumberAnimation { duration: 100 } }
                
                Text {
                    id: ssidText
                    text: wifiRoot.essid
                    color: Theme.blue
                    font.pixelSize: 18
                    font.family: Theme.fontFamily
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                }
            }
            
            Text {
                text: wifiRoot.icon
                font.pixelSize: 22
                color: Theme.blue
            }
        }
        onClicked: {
            Hyprland.dispatch("hl.exec_cmd('networkmanager_dmenu')");
        }
    }
}
