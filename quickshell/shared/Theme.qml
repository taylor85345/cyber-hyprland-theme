import QtQuick

pragma Singleton

QtObject {
    // Colors (defaults to garden)
    property color background: "#80000000"
    property color menuBackground: "#C0000000"
    property color widgetBackground: "#661E1E1E"
    property color shadow: "#66000000"
    property color grey: "#606060"
    property color black: "#3D4C5F"
    property color red: "#EE4F84"
    property color green: "#53E2AE"
    property color orange: "#F1FA8C"
    property color blue: "#92B6F4"
    property color purple: "#985EFF"
    property color teal: "#24D1E7"
    property color white: "#E5E5E5"

    property string fontFamily: "Inter Nerd Font"

    // Bar dimensions and styling
    property real barWidthMult: 0.98
    property real barHeight: 48
    property real barTopMargin: 9
    property real barBorderWidth: 2
    property color barBorderColor: green
    
    // Bar corner customization
    property real barBottomLeftRadius: 16
    property real barBottomRightRadius: 16
    property real barTopLeftRadius: 16
    property real barTopRightRadius: 16

    // Sidebar dimensions and styling
    property real sidebarWidth: 400
    property real sidebarHeightMult: 0.96
    property real sidebarTopMargin: 18
    property real sidebarBorderWidth: 2
    property color sidebarBorderColor: green
    property color sidebarTitleColor: white
    
    // Sidebar corner customization
    property real sidebarTopLeftRadius: 16
    property real sidebarBottomLeftRadius: 16
    property real sidebarTopRightRadius: 16
    property real sidebarBottomRightRadius: 16

    // Logo
    property string logoSource: "" // Empty uses logoText
    property string logoText: "󰌪"
    property string logoColor: green

    // Commands
    property string launcherCommand: "rofi -no-lazy-grab -show drun -theme ~/.config/hypr/themes/garden/rofi/launcher.rasi &"
}
