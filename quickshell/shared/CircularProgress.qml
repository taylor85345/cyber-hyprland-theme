import QtQuick
import QtQuick.Shapes

Item {
    id: root
    
    property real value: 0
    property real maxValue: 100
    property real strokeWidth: 4
    property color color: "blue"
    property color backgroundColor: "grey"
    property real size: 28
    
    width: size
    height: size
    
    property real animatedValue: value
    Behavior on animatedValue { NumberAnimation { duration: 500; easing.type: Easing.OutQuad } }
    
    Shape {
        id: shape
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4
        
        ShapePath {
            strokeColor: root.backgroundColor
            fillColor: "transparent"
            strokeWidth: root.strokeWidth
            capStyle: ShapePath.RoundCap
            
            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width - root.strokeWidth) / 2
                radiusY: (root.height - root.strokeWidth) / 2
                startAngle: -90
                sweepAngle: 360
            }
        }
        
        ShapePath {
            strokeColor: root.color
            fillColor: "transparent"
            strokeWidth: root.strokeWidth
            capStyle: ShapePath.RoundCap
            
            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width - root.strokeWidth) / 2
                radiusY: (root.height - root.strokeWidth) / 2
                startAngle: -90
                sweepAngle: (root.animatedValue / root.maxValue) * 360
            }
        }
    }
    
    Text {
        anchors.centerIn: parent
        text: ""
        font.pixelSize: root.size * 0.5
        color: root.color
        horizontalAlignment: Text.AlignHLeft
        verticalAlignment: Text.AlignVCenter
    }
}
