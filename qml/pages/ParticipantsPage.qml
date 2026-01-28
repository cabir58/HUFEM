import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../styles"
import "../components"

Rectangle {
    id: root
    color: Theme.bgMain
    
    // Sample data (will come from Python backend)
    property var participants: [
        {id: "1", tc: "12345678901", name: "Ahmet Yılmaz", unvan: "Tbp. Yzb.", brans: "Pilot", kurum: "Hv.K.K."},
        {id: "2", tc: "12345678902", name: "Mehmet Kaya", unvan: "Dr.", brans: "Havacılık Tıbbı", kurum: "SBÜ"},
        {id: "3", tc: "12345678903", name: "Ayşe Demir", unvan: "Uzm. Dr.", brans: "Fizyolog", kurum: "GATA"},
        {id: "4", tc: "12345678904", name: "Ali Çelik", unvan: "Plt. Ütğm.", brans: "Helikopter Pilotu", kurum: "Jndrm."},
        {id: "5", tc: "12345678905", name: "Fatma Şahin", unvan: "Hemşire", brans: "Havacılık Tıbbı", kurum: "SBÜ"},
    ]
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        // Header
        PageHeader {
            title: "Katılımcı Yönetimi"
            subtitle: "Eğitime katılan personel bilgileri"
            
            actions: [
                Button {
                    text: "Excel İçe Aktar"
                    icon: Icons.upload
                    variant: "secondary"
                },
                Button {
                    text: "Yeni Katılımcı"
                    icon: Icons.plus
                    onClicked: addDialog.open()
                }
            ]
        }
        
        // Content
        Rectangle {
            width: parent.width
            height: parent.height - 90
            color: Theme.bgMain
            
            Column {
                anchors {
                    fill: parent
                    margins: Theme.spacingXXL
                }
                spacing: Theme.spacingL
                
                // Toolbar
                Row {
                    width: parent.width
                    spacing: Theme.spacingM
                    
                    SearchBox {
                        placeholder: "Katılımcı ara (isim, kurum, branş...)"
                        width: 360
                        
                        onSearchChanged: (text) => {
                            // Filter logic
                            console.log("Search:", text)
                        }
                    }
                    
                    Item { width: Theme.spacingM }
                    
                    // Filters
                    ComboBox {
                        id: branchFilter
                        width: 160
                        model: ["Tüm Branşlar", "Pilot", "Helikopter Pilotu", "Havacılık Tıbbı", "Fizyolog"]
                        
                        background: Rectangle {
                            radius: Theme.radiusM
                            color: Theme.white
                            border.color: Theme.gray300
                            border.width: 1
                        }
                    }
                    
                    Item { Layout.fillWidth: true }
                    
                    Button {
                        text: "Excel'e Aktar"
                        icon: Icons.download
                        variant: "secondary"
                    }
                }
                
                // Data table
                Rectangle {
                    width: parent.width
                    height: parent.height - 60
                    radius: Theme.radiusL
                    color: Theme.white
                    border.color: Theme.gray200
                    border.width: 1
                    clip: true
                    
                    Column {
                        anchors.fill: parent
                        
                        // Table header
                        Rectangle {
                            width: parent.width
                            height: 48
                            color: Theme.gray50
                            
                            Row {
                                anchors {
                                    fill: parent
                                    leftMargin: Theme.spacingL
                                    rightMargin: Theme.spacingL
                                }
                                
                                TableHeader { text: "ID"; width: 60 }
                                TableHeader { text: "TC NO"; width: 120 }
                                TableHeader { text: "AD SOYAD"; width: 200 }
                                TableHeader { text: "ÜNVAN"; width: 120 }
                                TableHeader { text: "BRANŞ"; width: 160 }
                                TableHeader { text: "KURUM"; width: 120 }
                                TableHeader { text: "İŞLEMLER"; width: 100 }
                            }
                            
                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: Theme.gray200
                            }
                        }
                        
                        // Table body
                        ListView {
                            width: parent.width
                            height: parent.height - 48
                            clip: true
                            model: participants
                            
                            delegate: Rectangle {
                                width: ListView.view.width
                                height: 56
                                color: rowMouse.containsMouse ? Theme.gray50 : "transparent"
                                
                                Behavior on color {
                                    ColorAnimation { duration: 100 }
                                }
                                
                                Row {
                                    anchors {
                                        fill: parent
                                        leftMargin: Theme.spacingL
                                        rightMargin: Theme.spacingL
                                    }
                                    
                                    TableCell { text: modelData.id; width: 60 }
                                    TableCell { text: modelData.tc; width: 120 }
                                    TableCell { text: modelData.name; width: 200; bold: true }
                                    TableCell { text: modelData.unvan; width: 120 }
                                    TableCell { text: modelData.brans; width: 160 }
                                    TableCell { text: modelData.kurum; width: 120 }
                                    
                                    // Actions
                                    Row {
                                        width: 100
                                        height: parent.height
                                        spacing: Theme.spacingXS
                                        anchors.verticalCenter: parent.verticalCenter
                                        
                                        ActionButton {
                                            icon: "✏"
                                            tooltip: "Düzenle"
                                            onClicked: {
                                                console.log("Edit:", modelData.id)
                                            }
                                        }
                                        
                                        ActionButton {
                                            icon: "🗑"
                                            tooltip: "Sil"
                                            danger: true
                                            onClicked: {
                                                deleteConfirmDialog.participantId = modelData.id
                                                deleteConfirmDialog.participantName = modelData.name
                                                deleteConfirmDialog.open()
                                            }
                                        }
                                    }
                                }
                                
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
                                    acceptedButtons: Qt.NoButton
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Helper components
    component TableHeader: Rectangle {
        property string text: ""
        height: parent.height
        color: "transparent"
        
        Text {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            text: parent.text
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSmall
                weight: Font.DemiBold
                letterSpacing: 0.5
            }
            color: Theme.gray600
        }
    }
    
    component TableCell: Rectangle {
        property string text: ""
        property bool bold: false
        height: parent.height
        color: "transparent"
        
        Text {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            text: parent.text
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontNormal
                weight: bold ? Font.DemiBold : Font.Normal
            }
            color: Theme.gray700
            elide: Text.ElideRight
            width: parent.width - Theme.spacingS
        }
    }
    
    component ActionButton: Rectangle {
        property string icon: ""
        property string tooltip: ""
        property bool danger: false
        
        signal clicked()
        
        width: 32
        height: 32
        radius: Theme.radiusS
        color: actionMouse.containsMouse ? (danger ? Theme.errorLight : Theme.gray100) : "transparent"
        anchors.verticalCenter: parent.verticalCenter
        
        Behavior on color {
            ColorAnimation { duration: 100 }
        }
        
        Text {
            anchors.centerIn: parent
            text: parent.icon
            font.pixelSize: 14
        }
        
        MouseArea {
            id: actionMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.clicked()
        }
        
        ToolTip.visible: actionMouse.containsMouse
        ToolTip.text: tooltip
        ToolTip.delay: 500
    }
    
    // Add participant dialog
    Dialog {
        id: addDialog
        title: "Yeni Katılımcı"
        modal: true
        anchors.centerIn: parent
        width: 500
        standardButtons: Dialog.Cancel | Dialog.Save
        
        contentItem: Column {
            spacing: Theme.spacingM
            padding: Theme.spacingL
            
            TextField {
                width: parent.width - Theme.spacingL * 2
                placeholderText: "TC Kimlik No"
            }
            
            Row {
                spacing: Theme.spacingM
                
                TextField {
                    width: 200
                    placeholderText: "Ad *"
                }
                
                TextField {
                    width: 200
                    placeholderText: "Soyad *"
                }
            }
            
            ComboBox {
                width: parent.width - Theme.spacingL * 2
                model: ["Ünvan seçin...", "Dr.", "Uzm. Dr.", "Prof. Dr.", "Tbp. Yzb.", "Plt. Ütğm."]
            }
            
            ComboBox {
                width: parent.width - Theme.spacingL * 2
                model: ["Branş seçin...", "Pilot", "Helikopter Pilotu", "Havacılık Tıbbı", "Fizyolog"]
            }
            
            TextField {
                width: parent.width - Theme.spacingL * 2
                placeholderText: "Kurum"
            }
        }
        
        onAccepted: {
            console.log("Save participant")
        }
    }
    
    // Delete confirmation dialog
    Dialog {
        id: deleteConfirmDialog
        title: "Katılımcı Sil"
        modal: true
        anchors.centerIn: parent
        standardButtons: Dialog.Cancel | Dialog.Yes
        
        property string participantId: ""
        property string participantName: ""
        
        contentItem: Column {
            spacing: Theme.spacingL
            padding: Theme.spacingL
            
            Row {
                spacing: Theme.spacingM
                
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: Theme.errorLight
                    
                    Text {
                        anchors.centerIn: parent
                        text: "⚠"
                        font.pixelSize: 24
                    }
                }
                
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Text {
                        text: "Silmek istediğinize emin misiniz?"
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontMedium
                            weight: Font.DemiBold
                        }
                        color: Theme.gray800
                    }
                    
                    Text {
                        text: deleteConfirmDialog.participantName + " silinecek."
                        font.family: Theme.fontFamily
                        color: Theme.gray500
                    }
                }
            }
        }
        
        onAccepted: {
            console.log("Delete:", participantId)
        }
    }
}
