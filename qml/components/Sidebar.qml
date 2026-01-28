import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../styles"

Rectangle {
    id: root
    
    property bool collapsed: false
    property string currentPage: "dashboard"
    
    signal pageChanged(string pageName)
    
    width: collapsed ? Theme.sidebarCollapsedWidth : Theme.sidebarWidth
    color: Theme.bgSidebar
    
    Behavior on width {
        NumberAnimation { duration: Theme.animNormal; easing.type: Easing.OutQuad }
    }
    
    // Collapse toggle button
    Rectangle {
        id: collapseBtn
        anchors {
            right: parent.right
            rightMargin: -12
            top: parent.top
            topMargin: 100
        }
        width: 24
        height: 24
        radius: 12
        color: collapseMouse.containsMouse ? Theme.primary : Theme.bgSidebarHover
        z: 100
        
        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }
        
        Text {
            anchors.centerIn: parent
            text: collapsed ? Icons.chevronRight : Icons.chevronLeft
            font.pixelSize: 14
            color: Theme.white
            
            rotation: collapsed ? 0 : 180
            Behavior on rotation {
                NumberAnimation { duration: Theme.animNormal }
            }
        }
        
        MouseArea {
            id: collapseMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: collapsed = !collapsed
        }
    }
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        // Header / Logo
        Rectangle {
            width: parent.width
            height: 80
            color: "transparent"
            
            Row {
                anchors {
                    left: parent.left
                    leftMargin: Theme.spacingL
                    verticalCenter: parent.verticalCenter
                }
                spacing: Theme.spacingM
                
                // Logo icon
                Rectangle {
                    width: 40
                    height: 40
                    radius: Theme.radiusM
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Theme.primary }
                        GradientStop { position: 1.0; color: Theme.primaryDark }
                    }
                    
                    Text {
                        anchors.centerIn: parent
                        text: "🏥"
                        font.pixelSize: 20
                    }
                }
                
                // App name
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: collapsed ? 0 : 1
                    visible: opacity > 0
                    
                    Behavior on opacity {
                        NumberAnimation { duration: Theme.animNormal }
                    }
                    
                    Text {
                        text: "HUFEM"
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontLarge
                            weight: Font.Bold
                            letterSpacing: -0.5
                        }
                        color: Theme.white
                    }
                    
                    Text {
                        text: "Hava ve Uzay Fizyolojisi"
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontSmall
                        }
                        color: Theme.gray400
                    }
                }
            }
            
            // Bottom border
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Qt.rgba(1, 1, 1, 0.1)
            }
        }
        
        // Navigation
        Flickable {
            width: parent.width
            height: parent.height - 80
            contentHeight: navColumn.height
            clip: true
            
            Column {
                id: navColumn
                width: parent.width
                spacing: Theme.spacingXS
                padding: Theme.spacingS
                
                // Section: Genel
                Text {
                    text: collapsed ? "" : "GENEL"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontTiny
                        weight: Font.DemiBold
                        letterSpacing: 1
                    }
                    color: Theme.gray500
                    leftPadding: Theme.spacingM
                    topPadding: Theme.spacingL
                    bottomPadding: Theme.spacingS
                }
                
                NavItem {
                    icon: Icons.dashboard
                    text: "Dashboard"
                    active: currentPage === "dashboard"
                    collapsed: root.collapsed
                    onClicked: { currentPage = "dashboard"; pageChanged("dashboard") }
                }
                
                NavItem {
                    icon: Icons.users
                    text: "Katılımcılar"
                    active: currentPage === "participants"
                    collapsed: root.collapsed
                    onClicked: { currentPage = "participants"; pageChanged("participants") }
                }
                
                NavItem {
                    icon: Icons.folder
                    text: "Dönemler"
                    active: currentPage === "groups"
                    collapsed: root.collapsed
                    onClicked: { currentPage = "groups"; pageChanged("groups") }
                }
                
                NavItem {
                    icon: Icons.calendar
                    text: "Eğitimler"
                    active: currentPage === "sessions"
                    collapsed: root.collapsed
                    onClicked: { currentPage = "sessions"; pageChanged("sessions") }
                }
                
                // Section: Anketler
                Text {
                    text: collapsed ? "" : "ANKETLER"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontTiny
                        weight: Font.DemiBold
                        letterSpacing: 1
                    }
                    color: Theme.gray500
                    leftPadding: Theme.spacingM
                    topPadding: Theme.spacingXL
                    bottomPadding: Theme.spacingS
                }
                
                NavItem {
                    icon: Icons.clipboard
                    text: "Anket Yönetimi"
                    active: currentPage === "surveys"
                    collapsed: root.collapsed
                    onClicked: { currentPage = "surveys"; pageChanged("surveys") }
                }
                
                NavItem {
                    icon: Icons.edit
                    text: "Anket Doldur"
                    active: currentPage === "fill_survey"
                    collapsed: root.collapsed
                    onClicked: { currentPage = "fill_survey"; pageChanged("fill_survey") }
                }
                
                // Section: Analiz
                Text {
                    text: collapsed ? "" : "ANALİZ"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontTiny
                        weight: Font.DemiBold
                        letterSpacing: 1
                    }
                    color: Theme.gray500
                    leftPadding: Theme.spacingM
                    topPadding: Theme.spacingXL
                    bottomPadding: Theme.spacingS
                }
                
                NavItem {
                    icon: Icons.barChart
                    text: "İstatistikler"
                    active: currentPage === "statistics"
                    collapsed: root.collapsed
                    onClicked: { currentPage = "statistics"; pageChanged("statistics") }
                }
                
                NavItem {
                    icon: Icons.fileText
                    text: "Raporlar"
                    active: currentPage === "reports"
                    collapsed: root.collapsed
                    onClicked: { currentPage = "reports"; pageChanged("reports") }
                }
                
                // Spacer
                Item { width: 1; height: Theme.spacingHuge }
                
                // Version
                Text {
                    text: collapsed ? "v2" : "v2.0 • SBÜ"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontTiny
                    }
                    color: Theme.gray600
                    leftPadding: Theme.spacingM
                    bottomPadding: Theme.spacingL
                }
            }
        }
    }
}
