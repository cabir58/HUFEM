import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../styles"

Rectangle {
    id: root
    
    property string currentPage: "dashboard"
    signal pageChanged(string pageName)
    
    height: 70
    color: Theme.white
    
    // Bottom border
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: Theme.gray200
    }
    
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.spacingXXL
        anchors.rightMargin: Theme.spacingXXL
        spacing: Theme.spacingXL
        
        // Logo and Brand
        Row {
            spacing: Theme.spacingM
            Layout.alignment: Qt.AlignVCenter
            
            Rectangle {
                width: 48
                height: 48
                radius: Theme.radiusM
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.primary }
                    GradientStop { position: 1.0; color: Theme.primaryDark }
                }
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    anchors.centerIn: parent
                    text: "🏥"
                    font.pixelSize: 24
                }
            }
            
            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0
                
                Text {
                    text: "HUFEM"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontLarge
                        weight: Font.Bold
                        letterSpacing: -0.5
                    }
                    color: Theme.gray900
                }
                
                Text {
                    text: "Anket Yönetim Sistemi"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSmall
                    }
                    color: Theme.gray500
                }
            }
        }
        
        Item { Layout.fillWidth: true }
        
        // Navigation Tabs
        Row {
            spacing: Theme.spacingS
            Layout.alignment: Qt.AlignVCenter
            
            NavTab {
                text: "Ana Sayfa"
                icon: Icons.home
                active: currentPage === "dashboard"
                onClicked: { currentPage = "dashboard"; pageChanged("dashboard") }
            }
            
            NavTab {
                text: "Katılımcılar"
                icon: Icons.users
                active: currentPage === "participants"
                onClicked: { currentPage = "participants"; pageChanged("participants") }
            }
            
            NavTab {
                text: "Anket Yönetimi"
                icon: Icons.clipboard
                active: currentPage === "surveys"
                onClicked: { currentPage = "surveys"; pageChanged("surveys") }
            }
            
            NavTab {
                text: "Anket Doldur"
                icon: Icons.edit
                active: currentPage === "fill_survey"
                onClicked: { currentPage = "fill_survey"; pageChanged("fill_survey") }
            }
            
            NavTab {
                text: "Raporlar"
                icon: Icons.fileText
                active: currentPage === "reports"
                onClicked: { currentPage = "reports"; pageChanged("reports") }
            }
        }
        
        // Action buttons
        Row {
            spacing: Theme.spacingS
            Layout.alignment: Qt.AlignVCenter
            
            IconButton {
                icon: Icons.bell
                tooltip: "Bildirimler"
            }
            
            IconButton {
                icon: Icons.settings
                tooltip: "Ayarlar"
            }
        }
    }
    
    // Nav Tab Component
    component NavTab: Rectangle {
        property string text: ""
        property string icon: ""
        property bool active: false
        
        signal clicked()
        
        width: contentRow.width + Theme.spacingL * 2
        height: 42
        radius: Theme.radiusM
        color: active ? Theme.primary : (navMouse.containsMouse ? Theme.gray100 : "transparent")
        
        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }
        
        Row {
            id: contentRow
            anchors.centerIn: parent
            spacing: Theme.spacingS
            
            Text {
                text: parent.parent.icon
                font.pixelSize: 16
                color: active ? Theme.white : Theme.gray600
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Text {
                text: parent.parent.text
                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontNormal
                    weight: active ? Font.DemiBold : Font.Normal
                }
                color: active ? Theme.white : Theme.gray700
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        MouseArea {
            id: navMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.clicked()
        }
    }
    
    // Icon Button Component
    component IconButton: Rectangle {
        property string icon: ""
        property string tooltip: ""
        
        signal clicked()
        
        width: 40
        height: 40
        radius: Theme.radiusM
        color: iconMouse.containsMouse ? Theme.gray100 : "transparent"
        
        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }
        
        Text {
            anchors.centerIn: parent
            text: parent.icon
            font.pixelSize: 18
            color: Theme.gray600
        }
        
        MouseArea {
            id: iconMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.clicked()
        }
        
        ToolTip.visible: iconMouse.containsMouse
        ToolTip.text: tooltip
        ToolTip.delay: 500
    }
}
