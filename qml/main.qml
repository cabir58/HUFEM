import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import "styles"
import "components"
import "pages"

ApplicationWindow {
    id: window
    
    visible: true
    width: 1440
    height: 900
    minimumWidth: 1024
    minimumHeight: 768
    
    title: "HUFEM - Hava ve Uzay Fizyolojisi Eğitim Merkezi"
    color: Theme.bgMain
    
    // Frameless window style
    flags: Qt.Window | Qt.FramelessWindowHint
    
    // Window drag area
    property point dragPosition
    
    // Custom title bar
    Rectangle {
        id: titleBar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 36
        color: Theme.bgSidebar
        z: 100
        
        // Drag to move window
        MouseArea {
            anchors.fill: parent
            
            onPressed: (mouse) => {
                window.dragPosition = Qt.point(mouse.x, mouse.y)
            }
            
            onPositionChanged: (mouse) => {
                if (pressed) {
                    window.x += mouse.x - dragPosition.x
                    window.y += mouse.y - dragPosition.y
                }
            }
            
            onDoubleClicked: {
                if (window.visibility === Window.Maximized) {
                    window.showNormal()
                } else {
                    window.showMaximized()
                }
            }
        }
        
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Theme.spacingL
            anchors.rightMargin: Theme.spacingS
            spacing: 0
            
            // App icon and title
            Row {
                spacing: Theme.spacingS
                
                Text {
                    text: "🏥"
                    font.pixelSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                Text {
                    text: "HUFEM"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontNormal
                        weight: Font.DemiBold
                    }
                    color: Theme.white
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            
            Item { Layout.fillWidth: true }
            
            // Window controls
            Row {
                spacing: 0
                
                // Minimize
                Rectangle {
                    width: 46
                    height: 36
                    color: minimizeMouse.containsMouse ? Theme.bgSidebarHover : "transparent"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "─"
                        font.pixelSize: 12
                        color: Theme.gray400
                    }
                    
                    MouseArea {
                        id: minimizeMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: window.showMinimized()
                    }
                }
                
                // Maximize
                Rectangle {
                    width: 46
                    height: 36
                    color: maximizeMouse.containsMouse ? Theme.bgSidebarHover : "transparent"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "□"
                        font.pixelSize: 12
                        color: Theme.gray400
                    }
                    
                    MouseArea {
                        id: maximizeMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (window.visibility === Window.Maximized) {
                                window.showNormal()
                            } else {
                                window.showMaximized()
                            }
                        }
                    }
                }
                
                // Close
                Rectangle {
                    width: 46
                    height: 36
                    color: closeMouse.containsMouse ? Theme.error : "transparent"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "✕"
                        font.pixelSize: 12
                        color: closeMouse.containsMouse ? Theme.white : Theme.gray400
                    }
                    
                    MouseArea {
                        id: closeMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Qt.quit()
                    }
                }
            }
        }
    }
    
    // Main content
    Column {
        anchors {
            top: titleBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        spacing: 0
        
        // Top Navigation
        TopNavigation {
            id: topNav
            width: parent.width
            
            onPageChanged: (pageName) => {
                pageStack.currentPage = pageName
            }
        }
        
        // Page stack
        StackLayout {
            id: pageStack
            width: parent.width
            height: parent.height - topNav.height
            
            property string currentPage: "dashboard"
            currentIndex: {
                switch(currentPage) {
                    case "dashboard": return 0
                    case "participants": return 1
                    case "surveys": return 2
                    case "fill_survey": return 3
                    case "reports": return 4
                    default: return 0
                }
            }
            
            DashboardPage { }
            ParticipantsPage { }
            SurveysPage { }
            PlaceholderPage { title: "Anket Doldur"; subtitle: "Katılımcı anketlerini doldurun" }
            ReportsPage { }
        }
    }
    
    // Window resize handles
    MouseArea {
        id: rightResize
        width: 5
        anchors {
            right: parent.right
            top: titleBar.bottom
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeHorCursor
        
        onPressed: (mouse) => {
            dragPosition = Qt.point(mouse.x, mouse.y)
        }
        
        onPositionChanged: (mouse) => {
            if (pressed) {
                window.width += mouse.x - dragPosition.x
            }
        }
    }
    
    MouseArea {
        id: bottomResize
        height: 5
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeVerCursor
        
        onPressed: (mouse) => {
            dragPosition = Qt.point(mouse.x, mouse.y)
        }
        
        onPositionChanged: (mouse) => {
            if (pressed) {
                window.height += mouse.y - dragPosition.y
            }
        }
    }
    
    // Corner resize
    MouseArea {
        id: cornerResize
        width: 15
        height: 15
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        cursorShape: Qt.SizeFDiagCursor
        
        onPressed: (mouse) => {
            dragPosition = Qt.point(mouse.x, mouse.y)
        }
        
        onPositionChanged: (mouse) => {
            if (pressed) {
                window.width += mouse.x - dragPosition.x
                window.height += mouse.y - dragPosition.y
            }
        }
    }
}
