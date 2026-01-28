import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../styles"

Rectangle {
    id: root
    
    property string title: ""
    property string subtitle: ""
    property alias actions: actionsRow.children
    
    width: parent ? parent.width : 800
    height: 90
    color: Theme.white
    
    // Bottom border
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: Theme.gray200
    }
    
    RowLayout {
        anchors {
            fill: parent
            leftMargin: Theme.spacingXXL
            rightMargin: Theme.spacingXXL
        }
        
        // Title section
        Column {
            Layout.fillWidth: true
            spacing: Theme.spacingXS
            
            Text {
                text: root.title
                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontXLarge
                    weight: Font.DemiBold
                    letterSpacing: -0.5
                }
                color: Theme.gray900
            }
            
            Text {
                text: root.subtitle
                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontNormal
                }
                color: Theme.gray500
                visible: subtitle !== ""
            }
        }
        
        // Actions row
        Row {
            id: actionsRow
            spacing: Theme.spacingM
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }
    }
}
