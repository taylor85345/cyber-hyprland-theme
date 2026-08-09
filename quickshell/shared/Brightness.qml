import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "."

RowLayout {
    spacing: 5
    
    id: brightnessRoot
    property bool br_reveal: false
    property double brightness: 0
    
    // Process instance for setting brightness
    Process {
        id: setBright
    }

    // Poll brightness every 5 seconds like eww
    Process {
        id: getBright
        command: ["light"]
        running: true
        stdout: SplitParser {
            onRead: (line) => {
                if (line) brightnessRoot.brightness = parseFloat(line.trim());
            }
        }
    }
    
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: getBright.running = true
    }
    
    MouseArea {
        Layout.preferredWidth: 35 + (brightnessRoot.br_reveal ? barContainer.Layout.preferredWidth : 0)
        Layout.preferredHeight: 30
        hoverEnabled: true
        onEntered: brightnessRoot.br_reveal = true
        onExited: brightnessRoot.br_reveal = false
        
        RowLayout {
            anchors.fill: parent
            spacing: 3
            
            Rectangle {
                id: barContainer
                Layout.preferredWidth: brightnessRoot.br_reveal ? 70 : 0
                Layout.preferredHeight: 10
                color: "#22242b"
                radius: 16
                visible: brightnessRoot.br_reveal
                clip: true
                
                Rectangle {
                    width: (brightnessRoot.brightness / 100.0) * parent.width
                    height: parent.height
                    color: Theme.orange
                    radius: 16
                }
                
                Behavior on Layout.preferredWidth { NumberAnimation { duration: 100 } }
            }
            
            Text {
                text: ""
                font.pixelSize:18
                color: Theme.orange
            }
        }
        
        onWheel: (wheel) => {
            let newBright = brightnessRoot.brightness;
            if (wheel.angleDelta.y > 0) {
                newBright = Math.min(100, newBright + 1);
            } else {
                newBright = Math.max(0, newBright - 1);
            }
            brightnessRoot.brightness = newBright;
            setBright.command = ["light", "-S", newBright.toString()];
            setBright.startDetached();
        }
    }
}
