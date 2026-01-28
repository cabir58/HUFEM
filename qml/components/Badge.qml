import QtQuick
import "../styles"

Rectangle {
    id: root
    
    property string text: ""
    property string variant: "info" // info, success, warning, error
    
    implicitWidth: badgeText.width + Theme.spacingL
    implicitHeight: 24
    radius: 12
    
    color: {
        switch(variant) {
            case "success": return Theme.successLight
            case "warning": return Theme.warningLight
            case "error": return Theme.errorLight
            case "info": 
            default: return Theme.infoLight
        }
    }
    
    Text {
        id: badgeText
        anchors.centerIn: parent
        text: root.text
        font {
            family: Theme.fontFamily
            pixelSize: Theme.fontSmall
            weight: Font.DemiBold
        }
        color: {
            switch(variant) {
                case "success": return Theme.success
                case "warning": return Theme.warning
                case "error": return Theme.error
                case "info":
                default: return Theme.info
            }
        }
    }
}
