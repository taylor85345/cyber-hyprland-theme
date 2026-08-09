import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "."

Item {
    id: root
    
    property string buffer: ""
    
    ListModel {
        id: notifModel
    }
    
    function syncModel(newData) {
        // Simple sync: if count differs or first item differs, rebuild.
        // For a more "pro" feel, we should do a proper diff, but let's start with 
        // ensuring the remove animation works first.
        
        // Only update if the data is actually different to avoid flickering
        if (newData.length !== notifModel.count) {
            notifModel.clear();
            for (let i = 0; i < newData.length; i++) {
                const item = newData[i];
                notifModel.append({
                    notifId: item.id ? item.id.data : -1,
                    appname: item.appname ? item.appname.data : "Unknown",
                    summary: item.summary ? item.summary.data : "",
                    body: item.body ? item.body.data : "",
                    icon_path: (item.icon_path && item.icon_path.data) ? "file://" + item.icon_path.data : ""
                });
            }
        }
    }
    
    Process {
        id: dunstAction
    }
    
    Process {
        id: getHistory
        command: ["dunstctl", "history"]
        running: true
        
        stdout: SplitParser {
            onRead: (line) => {
                root.buffer += line + "\n";
            }
        }
        
        onExited: {
            if (root.buffer.trim().length > 0) {
                try {
                    const json = JSON.parse(root.buffer);
                    if (json && json.data && json.data[0]) {
                        root.syncModel(json.data[0].reverse());
                    }
                } catch (e) {
                    // console.error("Dunst history parse error:", e);
                }
                root.buffer = "";
            }
        }
    }
    
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            root.buffer = "";
            getHistory.running = true;
        }
    }
    
    ListView {
        id: notifList
        anchors.fill: parent
        model: notifModel
        spacing: 12
        clip: true
        
        remove: Transition {
            NumberAnimation { property: "x"; to: 400; duration: 300; easing.type: Easing.InQuad }
            NumberAnimation { property: "opacity"; to: 0; duration: 300 }
        }
        
        displaced: Transition {
            NumberAnimation { properties: "y"; duration: 300; easing.type: Easing.OutQuad }
        }

        delegate: Rectangle {
            id: delegateRoot
            width: ListView.view.width
            height: contentRow.implicitHeight + 24
            color: Theme.widgetBackground
            radius: 12
            border.color: Theme.green
            border.width: 2
            
            RowLayout {
                id: contentRow
                anchors.fill: parent
                anchors.margins: 12
                spacing: 15
                
                Image {
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    source: model.icon_path
                    fillMode: Image.PreserveAspectFit
                    visible: source != ""
                    
                    Rectangle {
                        anchors.fill: parent
                        color: Theme.green
                        opacity: 0.1
                        visible: parent.source == ""
                        radius: 6
                        Text {
                            anchors.centerIn: parent
                            text: "󰂚"
                            color: Theme.green
                            font.pixelSize: 24
                        }
                    }
                }
                
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4
                    
                    Text {
                        text: model.appname
                        color: Theme.green
                        font.pixelSize: 16
                        font.family: Theme.fontFamily
                        font.bold: true
                        elide: Text.ElideRight
                    }
                    
                    Text {
                        Layout.fillWidth: true
                        text: model.summary
                        color: Theme.white
                        font.pixelSize: 14
                        font.family: Theme.fontFamily
                        font.bold: true
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                    }
                    
                    Text {
                        Layout.fillWidth: true
                        text: model.body
                        color: Theme.white
                        opacity: 0.7
                        font.pixelSize: 12
                        font.family: Theme.fontFamily
                        wrapMode: Text.Wrap
                        maximumLineCount: 4
                        elide: Text.ElideRight
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                    if (model.notifId === -1) return;
                    
                    if (mouse.button === Qt.LeftButton) {
                        dunstAction.command = ["sh", "-c", `dunstctl history-pop ${model.notifId} && dunstctl action 0` ];
                        dunstAction.startDetached();
                    } else if (mouse.button === Qt.RightButton) {
                        dunstAction.command = ["dunstctl", "history-rm", model.notifId.toString()];
                        dunstAction.startDetached();
                        
                        // Trigger the ListView remove animation
                        notifModel.remove(model.index);
                    }
                }
            }
        }
    }
}
