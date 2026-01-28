import QtQuick
import QtQuick.Controls
import "../styles"

Rectangle {
    id: root
    
    property var headers: []  // ["ID", "Name", "Status"]
    property var columnWidths: []  // [60, 200, 100]
    property var data: []  // [{id: 1, name: "Test", status: "Active"}, ...]
    
    color: Theme.white
    radius: Theme.radiusL
    border.color: Theme.gray200
    border.width: 1
    clip: true
    
    Column {
        anchors.fill: parent
        
        // Header
        Rectangle {
            width: parent.width
            height: 48
            color: Theme.gray50
            
            Row {
                anchors {
                    fill: parent
                    leftMargin: Theme.spacingL
                }
                
                Repeater {
                    model: headers
                    
                    Rectangle {
                        width: columnWidths[index] || 120
                        height: parent.height
                        color: "transparent"
                        
                        Text {
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                            }
                            text: modelData
                            font {
                                family: Theme.fontFamily
                                pixelSize: Theme.fontSmall
                                weight: Font.DemiBold
                                capitalization: Font.AllUppercase
                                letterSpacing: 0.5
                            }
                            color: Theme.gray600
                        }
                    }
                }
            }
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Theme.gray200
            }
        }
        
        // Data rows
        ListView {
            width: parent.width
            height: parent.height - 48
            clip: true
            model: data
            
            delegate: Rectangle {
                width: ListView.view.width
                height: 52
                color: rowMouse.containsMouse ? Theme.gray50 : "transparent"
                
                Behavior on color {
                    ColorAnimation { duration: 100 }
                }
                
                Row {
                    anchors {
                        fill: parent
                        leftMargin: Theme.spacingL
                    }
                    
                    Repeater {
                        model: Object.keys(modelData).filter(k => k !== "actions")
                        
                        Rectangle {
                            width: columnWidths[index] || 120
                            height: parent.height
                            color: "transparent"
                            
                            Text {
                                anchors {
                                    left: parent.left
                                    verticalCenter: parent.verticalCenter
                                }
                                text: modelData[Object.keys(modelData).filter(k => k !== "actions")[index]] || ""
                                font {
                                    family: Theme.fontFamily
                                    pixelSize: Theme.fontNormal
                                }
                                color: Theme.gray700
                                elide: Text.ElideRight
                                width: parent.width - Theme.spacingM
                            }
                        }
                    }
                }
                
                // Bottom border
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 1
                    color: Theme.gray100
                }
                
                MouseArea {
                    id: rowMouse
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
            
            // Empty state
            Rectangle {
                anchors.fill: parent
                visible: data.length === 0
                color: "transparent"
                
                Column {
                    anchors.centerIn: parent
                    spacing: Theme.spacingM
                    
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "📋"
                        font.pixelSize: 48
                    }
                    
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Veri bulunamadı"
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontMedium
                        }
                        color: Theme.gray500
                    }
                }
            }
        }
    }
}
