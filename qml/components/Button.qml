import QtQuick
import QtQuick.Controls
import "../styles"

Rectangle {
    id: root
    
    property string text: "Button"
    property string icon: ""
    property string variant: "primary" // primary, secondary, success, danger, ghost
    property bool loading: false
    property bool disabled: false
    
    signal clicked()
    
    width: implicitWidth
    height: 40
    implicitWidth: contentRow.width + Theme.spacingXL * 2
    
    radius: Theme.radiusM
    color: {
        if (disabled) return Theme.gray200
        if (mouseArea.pressed) return pressedColor
        if (mouseArea.containsMouse) return hoverColor
        return baseColor
    }
    border.color: variant === "secondary" || variant === "ghost" ? Theme.gray300 : "transparent"
    border.width: variant === "secondary" || variant === "ghost" ? 1 : 0
    
    property color baseColor: {
        switch(variant) {
            case "primary": return Theme.primary
            case "secondary": return Theme.white
            case "success": return Theme.success
            case "danger": return Theme.error
            case "ghost": return "transparent"
            default: return Theme.primary
        }
    }
    
    property color hoverColor: {
        switch(variant) {
            case "primary": return Theme.primaryDark
            case "secondary": return Theme.gray50
            case "success": return Qt.darker(Theme.success, 1.1)
            case "danger": return Qt.darker(Theme.error, 1.1)
            case "ghost": return Theme.gray100
            default: return Theme.primaryDark
        }
    }
    
    property color pressedColor: {
        switch(variant) {
            case "primary": return Qt.darker(Theme.primary, 1.2)
            case "secondary": return Theme.gray100
            case "success": return Qt.darker(Theme.success, 1.2)
            case "danger": return Qt.darker(Theme.error, 1.2)
            case "ghost": return Theme.gray200
            default: return Qt.darker(Theme.primary, 1.2)
        }
    }
    
    property color textColor: {
        if (disabled) return Theme.gray500
        if (variant === "secondary" || variant === "ghost") return Theme.gray700
        return Theme.white
    }
    
    Behavior on color {
        ColorAnimation { duration: Theme.animFast }
    }
    
    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: Theme.spacingS
        
        // Loading indicator
        Rectangle {
            width: 16
            height: 16
            radius: 8
            color: "transparent"
            border.width: 2
            border.color: root.textColor
            visible: loading
            
            RotationAnimation on rotation {
                from: 0
                to: 360
                duration: 1000
                loops: Animation.Infinite
                running: loading
            }
            
            Rectangle {
                width: 8
                height: 2
                color: root.textColor
                anchors.centerIn: parent
            }
        }
        
        // Icon
        Text {
            visible: icon !== "" && !loading
            text: icon
            font.pixelSize: Theme.fontMedium
            color: root.textColor
            anchors.verticalCenter: parent.verticalCenter
        }
        
        // Text
        Text {
            text: root.text
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontNormal
                weight: Font.Medium
            }
            color: root.textColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: disabled ? Qt.ForbiddenCursor : Qt.PointingHandCursor
        
        onClicked: {
            if (!disabled && !loading) {
                root.clicked()
            }
        }
    }
    
    // Scale animation on press
    scale: mouseArea.pressed ? 0.98 : 1.0
    Behavior on scale {
        NumberAnimation { duration: 100 }
    }
}
