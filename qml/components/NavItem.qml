import QtQuick
import QtQuick.Controls
import "../styles"

Rectangle {
    id: root
    
    property string icon: ""
    property string text: ""
    property bool active: false
    property bool collapsed: false
    
    signal clicked()
    
    width: parent ? parent.width - Theme.spacingL * 2 : 200
    height: 44
    radius: Theme.radiusM
    
    color: {
        if (active) return Theme.bgSidebarActive
        if (mouseArea.containsMouse) return Theme.bgSidebarHover
        return "transparent"
    }
    
    Behavior on color {
        ColorAnimation { duration: Theme.animFast }
    }
    
    Row {
        anchors {
            left: parent.left
            leftMargin: Theme.spacingM
            verticalCenter: parent.verticalCenter
        }
        spacing: collapsed ? 0 : Theme.spacingM
        
        // Icon
        Rectangle {
            width: 28
            height: 28
            radius: Theme.radiusS
            color: active ? "rgba(255,255,255,0.2)" : "transparent"
            
            Text {
                anchors.centerIn: parent
                text: root.icon
                font.pixelSize: 16
                color: active ? Theme.white : Theme.gray400
                
                Behavior on color {
                    ColorAnimation { duration: Theme.animFast }
                }
            }
        }
        
        // Text
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.text
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontNormal
                weight: active ? Font.DemiBold : Font.Medium
            }
            color: active ? Theme.white : Theme.gray400
            opacity: collapsed ? 0 : 1
            
            Behavior on opacity {
                NumberAnimation { duration: Theme.animNormal }
            }
            
            Behavior on color {
                ColorAnimation { duration: Theme.animFast }
            }
        }
    }
    
    // Active indicator
    Rectangle {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        width: 3
        height: parent.height - Theme.spacingL
        radius: 2
        color: Theme.white
        visible: active
        opacity: active ? 1 : 0
        
        Behavior on opacity {
            NumberAnimation { duration: Theme.animFast }
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        
        onClicked: root.clicked()
    }
    
    // Tooltip for collapsed mode
    ToolTip {
        visible: collapsed && mouseArea.containsMouse
        text: root.text
        delay: 500
    }
}
