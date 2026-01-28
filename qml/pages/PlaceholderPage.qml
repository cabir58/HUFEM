import QtQuick
import QtQuick.Controls
import "../styles"
import "../components"

Rectangle {
    id: root
    color: Theme.bgMain
    
    property string title: "Sayfa"
    property string subtitle: "Açıklama"
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        PageHeader {
            title: root.title
            subtitle: root.subtitle
        }
        
        // Content
        Rectangle {
            width: parent.width
            height: parent.height - 90
            color: Theme.bgMain
            
            Column {
                anchors.centerIn: parent
                spacing: Theme.spacingXL
                
                // Icon
                Rectangle {
                    width: 120
                    height: 120
                    radius: 60
                    color: Theme.primaryFaded
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    Text {
                        anchors.centerIn: parent
                        text: "🚧"
                        font.pixelSize: 56
                    }
                }
                
                // Text
                Column {
                    spacing: Theme.spacingS
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    Text {
                        text: "Geliştirme Aşamasında"
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontXLarge
                            weight: Font.DemiBold
                        }
                        color: Theme.gray800
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    
                    Text {
                        text: "Bu sayfa yakında kullanıma açılacak"
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontNormal
                        }
                        color: Theme.gray500
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                
                // Progress indicator
                Column {
                    spacing: Theme.spacingS
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    Rectangle {
                        width: 200
                        height: 6
                        radius: 3
                        color: Theme.gray200
                        anchors.horizontalCenter: parent.horizontalCenter
                        
                        Rectangle {
                            width: parent.width * 0.65
                            height: parent.height
                            radius: 3
                            color: Theme.primary
                            
                            // Animated shimmer effect
                            Rectangle {
                                id: shimmer
                                width: 40
                                height: parent.height
                                radius: 3
                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop { position: 0.0; color: "transparent" }
                                    GradientStop { position: 0.5; color: Qt.rgba(1, 1, 1, 0.3) }
                                    GradientStop { position: 1.0; color: "transparent" }
                                }
                                
                                SequentialAnimation on x {
                                    loops: Animation.Infinite
                                    NumberAnimation { from: -40; to: 200 * 0.65; duration: 1500 }
                                    PauseAnimation { duration: 500 }
                                }
                            }
                            clip: true
                        }
                    }
                    
                    Text {
                        text: "Tamamlanma: %65"
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontSmall
                        }
                        color: Theme.gray400
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                
                // Action button
                Button {
                    text: "Dashboard'a Dön"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        // Navigate to dashboard
                    }
                }
            }
        }
    }
}
