import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "../styles"

Rectangle {
    id: root
    
    property string icon: ""
    property string title: ""
    property string subtitle: ""
    property string count: "0"
    property color accentColor: Theme.primary
    
    signal clicked()
    
    width: 280
    height: 160
    radius: Theme.radiusL
    color: Theme.white
    border.color: mouseArea.containsMouse ? accentColor : Theme.gray200
    border.width: 1
    
    // Top accent line
    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 4
        color: accentColor
        radius: Theme.radiusL
        
        Rectangle {
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            height: 2
            color: accentColor
        }
    }
    
    // Shadow
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: Theme.shadowColorLight
        shadowBlur: 0.15
        shadowVerticalOffset: 3
    }
    
    Column {
        anchors {
            fill: parent
            margins: Theme.spacingXL
            topMargin: Theme.spacingXL + 8
        }
        spacing: Theme.spacingM
        
        // Header row
        Row {
            width: parent.width
            spacing: Theme.spacingM
            
            // Icon
            Rectangle {
                width: 48
                height: 48
                radius: Theme.radiusM
                color: Qt.rgba(accentColor.r, accentColor.g, accentColor.b, 0.12)
                
                Text {
                    anchors.centerIn: parent
                    text: root.icon
                    font.pixelSize: 24
                }
            }
            
            // Count
            Column {
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: root.count
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontXLarge
                        weight: Font.Bold
                    }
                    color: accentColor
                }
                
                Text {
                    text: "eğitim"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSmall
                    }
                    color: Theme.gray500
                }
            }
        }
        
        // Title
        Text {
            text: root.title
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontMedium
                weight: Font.DemiBold
            }
            color: Theme.gray800
        }
        
        // Subtitle
        Text {
            text: root.subtitle
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSmall
            }
            color: Theme.gray500
            width: parent.width
            elide: Text.ElideRight
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
    
    // Hover effect
    scale: mouseArea.containsMouse ? 1.02 : 1.0
    Behavior on scale {
        NumberAnimation { duration: Theme.animFast; easing.type: Easing.OutQuad }
    }
}
