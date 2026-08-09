import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import "."

RowLayout {
    spacing: 5
    
    id: volumeRoot
    
    property bool vol_reveal: false
    
    readonly property var sink: Pipewire.defaultAudioSink
    
    // Track the sink to ensure properties are reactive
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    
    MouseArea {
        Layout.preferredWidth: 35 + (volumeRoot.vol_reveal ? barContainer.Layout.preferredWidth : 0)
        Layout.preferredHeight: 30
        hoverEnabled: true
        onEntered: volumeRoot.vol_reveal = true
        onExited: volumeRoot.vol_reveal = false
        
        RowLayout {
            anchors.fill: parent
            spacing: 3
            
            Rectangle {
                id: barContainer
                Layout.preferredWidth: volumeRoot.vol_reveal ? 70 : 0
                Layout.preferredHeight: 10
                color: "#22242b"
                radius: 16
                visible: volumeRoot.vol_reveal
                clip: true
                
                Rectangle {
                    width: (volumeRoot.sink && volumeRoot.sink.audio) ? (volumeRoot.sink.audio.volume / 1.0) * parent.width : 0
                    height: parent.height
                    color: Theme.blue
                    radius: 16
                }
                Behavior on Layout.preferredWidth { NumberAnimation { duration: 100 } }
            }

            Text {
                text: (volumeRoot.sink && volumeRoot.sink.audio && volumeRoot.sink.audio.muted) ? "󰝟" : "󰕾"
                font.pixelSize: 22
                color: Theme.blue
            }
        }
        
        onWheel: (wheel) => {
            if (volumeRoot.sink && volumeRoot.sink.audio) {
                if (wheel.angleDelta.y > 0) {
                    volumeRoot.sink.audio.volume = Math.min(1.0, volumeRoot.sink.audio.volume + 0.05);
                } else {
                    volumeRoot.sink.audio.volume = Math.max(0.0, volumeRoot.sink.audio.volume - 0.05);
                }
            }
        }
        
        onClicked: {
            if (volumeRoot.sink && volumeRoot.sink.audio) {
                volumeRoot.sink.audio.muted = !volumeRoot.sink.audio.muted;
            }
        }
    }
}
