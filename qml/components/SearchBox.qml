import QtQuick
import QtQuick.Controls
import "../styles"

Rectangle {
    id: root
    
    property alias text: textInput.text
    property string placeholder: "Ara..."
    property bool showClearButton: true
    
    signal searchChanged(string text)
    signal searchSubmit(string text)
    
    width: 300
    height: 44
    radius: Theme.radiusM
    color: Theme.white
    border.color: textInput.activeFocus ? Theme.primary : Theme.gray300
    border.width: textInput.activeFocus ? 2 : 1
    
    Behavior on border.color {
        ColorAnimation { duration: Theme.animFast }
    }
    
    Row {
        anchors {
            fill: parent
            leftMargin: Theme.spacingM
            rightMargin: Theme.spacingM
        }
        spacing: Theme.spacingS
        
        // Search icon
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Icons.search
            font.pixelSize: 16
            color: Theme.gray400
        }
        
        // Text input
        TextInput {
            id: textInput
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 60
            
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontNormal
            }
            color: Theme.gray900
            selectByMouse: true
            
            onTextChanged: root.searchChanged(text)
            onAccepted: root.searchSubmit(text)
            
            // Placeholder
            Text {
                anchors.fill: parent
                text: root.placeholder
                font: parent.font
                color: Theme.gray400
                visible: !parent.text && !parent.activeFocus
            }
        }
        
        // Clear button
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            radius: 12
            color: clearMouse.containsMouse ? Theme.gray100 : "transparent"
            visible: showClearButton && textInput.text.length > 0
            
            Text {
                anchors.centerIn: parent
                text: Icons.close
                font.pixelSize: 12
                color: Theme.gray500
            }
            
            MouseArea {
                id: clearMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: textInput.text = ""
            }
        }
    }
}
