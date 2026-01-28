import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "../styles"

Rectangle {
    id: root
    
    property string icon: ""
    property string value: "0"
    property string label: ""
    property color accentColor: Theme.primary
    property string trend: "" // e.g., "+12%"
    property bool trendUp: true
    
    signal clicked()
    
    width: 220
    height: 140
    radius: Theme.radiusXL
    color: Theme.white
    border.color: mouseArea.containsMouse ? accentColor : Theme.gray200
    border.width: 1
    
    Behavior on border.color {
        ColorAnimation { duration: Theme.animFast }
    }
    
    // Shadow
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: Theme.shadowColorLight
        shadowBlur: 0.2
        shadowVerticalOffset: 4
    }
    
    // Left accent bar
    Rectangle {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            topMargin: Theme.spacingM
            bottomMargin: Theme.spacingM
        }
        width: 4
        radius: 2
        color: accentColor
    }
    
    Column {
        anchors {
            fill: parent
            margins: Theme.spacingXL
            leftMargin: Theme.spacingXL + 8
        }
        spacing: Theme.spacingS
        
        // Icon
        Rectangle {
            width: 44
            height: 44
            radius: Theme.radiusL
            color: Qt.rgba(accentColor.r, accentColor.g, accentColor.b, 0.12)
            
            Text {
                anchors.centerIn: parent
                text: root.icon
                font.pixelSize: 22
            }
        }
        
        // Value
        Text {
            text: root.value
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontHuge
                weight: Font.Bold
            }
            color: Theme.gray900
        }
        
        // Label and trend
        Row {
            spacing: Theme.spacingS
            
            Text {
                text: root.label
                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontSmall
                    weight: Font.Medium
                }
                color: Theme.gray500
            }
            
            // Trend badge
            Rectangle {
                visible: trend !== ""
                height: 20
                width: trendText.width + Theme.spacingM
                radius: 10
                color: trendUp ? Theme.successLight : Theme.errorLight
                
                Text {
                    id: trendText
                    anchors.centerIn: parent
                    text: root.trend
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontTiny
                        weight: Font.DemiBold
                    }
                    color: trendUp ? Theme.success : Theme.error
                }
            }
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
    
    // Hover scale effect
    scale: mouseArea.containsMouse ? 1.02 : 1.0
    Behavior on scale {
        NumberAnimation { duration: Theme.animFast; easing.type: Easing.OutQuad }
    }
}
