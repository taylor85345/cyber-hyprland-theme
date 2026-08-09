import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell
import "."

MouseArea {
    id: activeWindowRoot
    
    // Explicitly set width and height for anchors.centerIn to work in Bar.qml
    width: contentLayout.implicitWidth
    height: 48 
    hoverEnabled: true
    
    property string visibleText: "Welcome to Hyprland"
    property string klass: ""
    property string title: ""
    property bool control_reveal: containsMouse && Hyprland.activeToplevel !== null

    // Trigger update when window focus changes
    Connections {
        target: Hyprland
        function onActiveToplevelChanged() {
            if (Hyprland.activeToplevel) {
                activeWindowRoot.title = Hyprland.activeToplevel.title;
                getClassProcess.running = true;
            } else {
                activeWindowRoot.visibleText = "Welcome to Hyprland";
                activeWindowRoot.klass = "";
                activeWindowRoot.title = "";
            }
        }
    }

    // Trigger update when title changes on the current window
    Connections {
        target: Hyprland.activeToplevel ? Hyprland.activeToplevel : null
        ignoreUnknownSignals: true
        function onTitleChanged() {
            if (Hyprland.activeToplevel) {
                activeWindowRoot.title = Hyprland.activeToplevel.title;
                getClassProcess.running = true;
            }
        }
    }

    Process {
        id: getClassProcess
        command: ["sh", "-c", "hyprctl activewindow | awk '/class:/ {print $2}'"]
        stdout: SplitParser {
            onRead: (line) => {
                if (line) {
                    activeWindowRoot.klass = line.trim();
                    activeWindowRoot.visibleText = `${activeWindowRoot.klass} | ${activeWindowRoot.title}`;
                }
            }
        }
    }

    RowLayout {
        id: contentLayout
        anchors.centerIn: parent
        spacing: 15

        RowLayout {
            spacing: 8
            Image {
                id: appIcon
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
                source: activeWindowRoot.klass !== "" ? Quickshell.iconPath(activeWindowRoot.klass.toLowerCase(), "") : ""
                visible: source != ""
                fillMode: Image.PreserveAspectFit
            }
            
            Text {
                text: activeWindowRoot.visibleText
                color: Theme.white
                font.family: Theme.fontFamily
                font.pixelSize: 20
                font.bold: true
                Layout.maximumWidth: 450
                elide: Text.ElideRight
            }
        }

        // Window Controls
        RowLayout {
            id: controls
            spacing: 15
            Layout.preferredWidth: activeWindowRoot.control_reveal ? implicitWidth : 0
            clip: true
            
            Behavior on Layout.preferredWidth { NumberAnimation { duration: 350; easing.type: Easing.OutQuad } }

            Text {
                text: "󱂬" // Float
                color: Theme.white
                font.pixelSize: 26
                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("hl.dsp.window.float({ action = 'toggle' })")
                }
            }

            Text {
                text: "" // Fullscreen
                color: Theme.white
                font.pixelSize: 26
                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("hl.dsp.window.fullscreen({ mode = 'maximized' })")
                }
            }

            Text {
                text: "" // Kill
                color: Theme.white
                font.pixelSize: 26
                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("hl.dsp.window.close()")
                }
            }
        }
    }
}
