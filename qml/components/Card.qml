import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "../styles"

Rectangle {
    id: root
    
    property string title: ""
    property bool elevated: true
    property alias content: contentLoader.sourceComponent
    
    color: Theme.white
    radius: Theme.radiusL
    border.color: Theme.gray200
    border.width: 1
    
    // Shadow effect
    layer.enabled: elevated
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: Theme.shadowColor
        shadowBlur: 0.3
        shadowVerticalOffset: 4
        shadowHorizontalOffset: 0
    }
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        // Header
        Rectangle {
            width: parent.width
            height: title ? 56 : 0
            visible: title !== ""
            color: "transparent"
            
            Text {
                anchors {
                    left: parent.left
                    leftMargin: Theme.spacingXL
                    verticalCenter: parent.verticalCenter
                }
                text: root.title
                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontMedium
                    weight: Font.DemiBold
                }
                color: Theme.gray800
            }
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Theme.gray100
            }
        }
        
        // Content
        Loader {
            id: contentLoader
            width: parent.width
            // Height will be determined by content
        }
    }
}
