import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "."

RowLayout {
    id: workspacesRoot
    spacing: 6
    
    property var screen
    
    readonly property var icons: ["", "", "", "", "", "", "", "", ""]
    
    // Map of occupied workspace IDs for reactive lookups
    readonly property var occupiedMap: {
        const map = {};
        const wsList = Hyprland.workspaces.values || [];
        if (wsList.length > 0) {
            for (let i = 0; i < wsList.length; i++) {
                map[wsList[i].id] = true;
            }
        } else {
            for (let i = 0; i < Hyprland.workspaces.count; i++) {
                const ws = Hyprland.workspaces.get(i);
                if (ws) map[ws.id] = true;
            }
        }
        return map;
    }
    
    // Identify this monitor and others
    readonly property var currentMonitor: Hyprland.monitorFor(screen)
    
    readonly property var otherVisibleWorkspaces: {
        const visible = {};
        if (!Hyprland.monitors) return visible;
        const monitors = Hyprland.monitors.values || [];
        
        // Fallback for monitors iteration
        const mCount = monitors.length > 0 ? monitors.length : Hyprland.monitors.count;
        
        for (let i = 0; i < mCount; i++) {
            const m = monitors.length > 0 ? monitors[i] : Hyprland.monitors.get(i);
            if (m && currentMonitor && m.name !== currentMonitor.name && m.activeWorkspace) {
                visible[m.activeWorkspace.id] = true;
            }
        }
        return visible;
    }
    
    Repeater {
        model: 9
        
        delegate: MouseArea {
            id: workspaceButton
            Layout.preferredWidth: 35
            Layout.preferredHeight: 30
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            
            readonly property int wsId: modelData + 1
            readonly property bool isOccupied: workspacesRoot.occupiedMap[wsId] === true
            readonly property bool isThisMonitorActive: workspacesRoot.currentMonitor && 
                                                      workspacesRoot.currentMonitor.activeWorkspace && 
                                                      workspacesRoot.currentMonitor.activeWorkspace.id === wsId
            readonly property bool isOtherMonitorVisible: workspacesRoot.otherVisibleWorkspaces[wsId] === true
            
            Text {
                anchors.centerIn: parent
                text: workspacesRoot.icons[modelData]
                font.pixelSize: 28
                font.family: "Inter Nerd Font"
                
                color: {
                    if (workspaceButton.isThisMonitorActive) return Theme.green;
                    if (workspaceButton.isOtherMonitorVisible) return Theme.orange;
                    if (workspaceButton.isOccupied) return Theme.white;
                    return Theme.grey;
                }
                
                Behavior on color { ColorAnimation { duration: 250 } }
            }
            
            onClicked: (mouse) => {
                if (mouse.button === Qt.LeftButton) {
                    Hyprland.dispatch(`hl.dsp.focus({ workspace = '${wsId}' })`);
                } else if (mouse.button === Qt.RightButton) {
                    Hyprland.dispatch(`hl.dsp.focus({ workspace = '${wsId}' })`);
                    shellExec.command = ["hyprctl", "eval", "LaunchWSDefault()"];
                    shellExec.startDetached();
                }
            }
        }
    }
}
