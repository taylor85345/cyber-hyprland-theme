//@ pragma UseQApplication
import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Io
import "shared"

ShellRoot {
    id: root
    
    property bool notificationsActive: false
    property bool barVisible: false
    
    Component.onCompleted: {
        barVisible = true;
        
        // Colors
        Theme.background =                "#90000000";
        Theme.menuBackground =            "#C0000000";
        Theme.widgetBackground =          "#661E1E1E";
        Theme.grey =                      "#404040";
        Theme.black =                     "#282A36";
        Theme.red =                       "#F37F97";
        Theme.green =                     "#5ADECD";
        Theme.orange =                    "#F2A272";
        Theme.blue =                      "#8897F4";
        Theme.purple =                    "#C574DD";
        Theme.teal =                      "#79E6F3";
        Theme.whoite =                    "#FDFDFD";

        Theme.fontFamily =                "Mononoki Nerd Font";

        // Bar
        Theme.barWidthMult =              0.99;
        Theme.barHeight =                 50;
        Theme.barTopMargin =              0;
        Theme.barBorderWidth =            0;
        Theme.barBorderColor =            Theme.black;

        // Bar corner customization
        Theme.barTopLeftRadius =          0;
        Theme.barTopRightRadius =         0;
        Theme.barBottomLeftRadius =       20;
        Theme.barBottomRightRadius =      20;

        // Sidebar
        Theme.sidebarWidth =              350;
        Theme.sidebarHeightMult =         0.98;
        Theme.sidebarTopMargin =          12;
        Theme.sidebarBorderWidth =        0;
        Theme.sidebarBorderColor =        Theme.black;
        Theme.sidebarTitleColor =         Theme.white;

        // Sidebar corner customization
        Theme.sidebarTopLeftRadius =      20;
        Theme.sidebarBottomLeftRadius =   20;
        Theme.sidebarTopRightRadius =     0;
        Theme.sidebarBottomRightRadius =  0;

        // Logo
        Theme.logoSource =                "images/favicon.ico";
        Theme.logoText =                  "󰌪";
        Theme.logoColor =                 Theme.white;

        // Commands
        Theme.launcherCommand =           "rofi -no-lazy-grab -show drun -theme ~/.config/hypr/themes/cyber/rofi/launcher.rasi &";
    }
    
    IpcHandler {
        target: "bar"
        function toggleBar(): void {
            root.barVisible = !root.barVisible
        }
    }
    
    Variants {
        model: Quickshell.screens
        
        PanelWindow {
            id: barWindow
            property var modelData
            screen: modelData
            
            exclusiveZone: root.barVisible ? implicitHeight : 0
            visible: root.barVisible || bar.animating
            mask: Region { item: bar }
            
            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: Theme.barHeight + Theme.barTopMargin
            color: "transparent"
            
            Bar {
                id: bar
                screen: barWindow.screen
                window: barWindow
                barVisible: root.barVisible
                onToggleNotifications: root.notificationsActive = !root.notificationsActive
            }
        }
    }
    
    Variants {
        model: Quickshell.screens
        
        NotificationSidebar {
            property var modelData
            screen: modelData
            active: root.notificationsActive
            onHideRequested: root.notificationsActive = false
        }
    }
}
