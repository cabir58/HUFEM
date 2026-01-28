import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../styles"
import "../components"

Rectangle {
    id: root
    color: Theme.bgMain
    
    // Sample survey data
    property var surveys: [
        {id: 1, name: "Hipoksi Eğitimi Memnuniyet Anketi", device: "Hipoksi Cihazı", questions: 12, responses: 156, status: "active", created: "15.01.2026"},
        {id: 2, name: "SD Eğitimi Değerlendirme Anketi", device: "SD Cihazı", questions: 15, responses: 98, status: "active", created: "10.01.2026"},
        {id: 3, name: "Gece Görüş Eğitimi Anketi", device: "Gece Görüş Lab", questions: 10, responses: 84, status: "active", created: "05.01.2026"},
        {id: 4, name: "Eğitim Öncesi Genel Değerlendirme", device: "Tüm Cihazlar", questions: 8, responses: 245, status: "active", created: "01.01.2026"},
    ]
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        // Header
        PageHeader {
            title: "Anket Yönetimi"
            subtitle: "Anketleri oluşturun, düzenleyin ve yönetin"
            
            actions: [
                Button {
                    text: "Şablon İçe Aktar"
                    icon: Icons.upload
                    variant: "secondary"
                }
                ,
                Button {
                    text: "Yeni Anket Oluştur"
                    icon: Icons.plus
                    onClicked: createSurveyDialog.open()
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
                
                // Stats Row
                Row {
                    spacing: Theme.spacingL
                    width: parent.width
                    
                    StatCard {
                        icon: Icons.clipboard
                        value: surveys.length.toString()
                        label: "Toplam Anket"
                        accentColor: Theme.primary
                        width: (parent.width - Theme.spacingL * 3) / 4
                    }
                    
                    StatCard {
                        icon: Icons.check
                        value: "583"
                        label: "Toplam Yanıt"
                        accentColor: Theme.success
                        width: (parent.width - Theme.spacingL * 3) / 4
                    }
                    
                    StatCard {
                        icon: Icons.users
                        value: "156"
                        label: "Katılımcı"
                        accentColor: Theme.secondary
                        width: (parent.width - Theme.spacingL * 3) / 4
                    }
                    
                    StatCard {
                        icon: Icons.barChart
                        value: "94%"
                        label: "Ortalama Tamamlama"
                        accentColor: Theme.warning
                        width: (parent.width - Theme.spacingL * 3) / 4
                    }
                }
                
                // Toolbar
                Row {
                    width: parent.width
                    spacing: Theme.spacingM
                    
                    SearchBox {
                        placeholder: "Anket ara..."
                        width: 360
                    }
                    
                    Item { width: Theme.spacingM }
                    
                    ComboBox {
                        width: 160
                        model: ["Tüm Anketler", "Aktif", "Taslak", "Arşivlenmiş"]
                        
                        background: Rectangle {
                            radius: Theme.radiusM
                            color: Theme.white
                            border.color: Theme.gray300
                            border.width: 1
                        }
                    }
                    
                    ComboBox {
                        width: 180
                        model: ["Tüm Cihazlar", "Hipoksi Cihazı", "SD Cihazı", "Gece Görüş Lab"]
                        
                        background: Rectangle {
                            radius: Theme.radiusM
                            color: Theme.white
                            border.color: Theme.gray300
                            border.width: 1
                        }
                    }
                    
                    Item { Layout.fillWidth: true }
                    
                    Button {
                        text: "Dışa Aktar"
                        icon: Icons.download
                        variant: "secondary"
                    }
                }
                
                // Surveys Grid
                GridView {
                    width: parent.width
                    height: parent.height - 200
                    cellWidth: (width - Theme.spacingL) / 2
                    cellHeight: 240
                    clip: true
                    
                    model: surveys
                    
                    delegate: Rectangle {
                        width: GridView.view.cellWidth - Theme.spacingM
                        height: GridView.view.cellHeight - Theme.spacingM
                        radius: Theme.radiusL
                        color: Theme.white
                        border.color: surveyMouse.containsMouse ? Theme.primary : Theme.gray200
                        border.width: surveyMouse.containsMouse ? 2 : 1
                        
                        Behavior on border.color {
                            ColorAnimation { duration: Theme.animFast }
                        }
                        
                        Column {
                            anchors {
                                fill: parent
                                margins: Theme.spacingXL
                            }
                            spacing: Theme.spacingM
                            
                            // Header
                            Row {
                                width: parent.width
                                spacing: Theme.spacingM
                                
                                Rectangle {
                                    width: 48
                                    height: 48
                                    radius: Theme.radiusM
                                    color: Theme.primaryFaded
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: Icons.clipboard
                                        font.pixelSize: 24
                                    }
                                }
                                
                                Column {
                                    width: parent.width - 60
                                    spacing: Theme.spacingXS
                                    
                                    Text {
                                        text: modelData.name
                                        font {
                                            family: Theme.fontFamily
                                            pixelSize: Theme.fontMedium
                                            weight: Font.Bold
                                        }
                                        color: Theme.gray800
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        maximumLineCount: 2
                                        elide: Text.ElideRight
                                    }
                                    
                                    Badge {
                                        text: modelData.device
                                        variant: "primary"
                                    }
                                }
                            }
                            
                            // Stats
                            Row {
                                spacing: Theme.spacingXL
                                width: parent.width
                                
                                Column {
                                    spacing: Theme.spacingXS
                                    
                                    Text {
                                        text: modelData.questions.toString()
                                        font {
                                            family: Theme.fontFamily
                                            pixelSize: Theme.fontLarge
                                            weight: Font.Bold
                                        }
                                        color: Theme.primary
                                    }
                                    
                                    Text {
                                        text: "Soru"
                                        font {
                                            family: Theme.fontFamily
                                            pixelSize: Theme.fontSmall
                                        }
                                        color: Theme.gray500
                                    }
                                }
                                
                                Column {
                                    spacing: Theme.spacingXS
                                    
                                    Text {
                                        text: modelData.responses.toString()
                                        font {
                                            family: Theme.fontFamily
                                            pixelSize: Theme.fontLarge
                                            weight: Font.Bold
                                        }
                                        color: Theme.success
                                    }
                                    
                                    Text {
                                        text: "Yanıt"
                                        font {
                                            family: Theme.fontFamily
                                            pixelSize: Theme.fontSmall
                                        }
                                        color: Theme.gray500
                                    }
                                }
                                
                                Item { width: 1; height: 1 }
                                
                                Column {
                                    spacing: Theme.spacingXS
                                    
                                    Text {
                                        text: modelData.created
                                        font {
                                            family: Theme.fontFamily
                                            pixelSize: Theme.fontSmall
                                        }
                                        color: Theme.gray600
                                    }
                                    
                                    Text {
                                        text: "Oluşturulma"
                                        font {
                                            family: Theme.fontFamily
                                            pixelSize: Theme.fontSmall
                                        }
                                        color: Theme.gray500
                                    }
                                }
                            }
                            
                            Item { height: Theme.spacingS }
                            
                            // Actions
                            Row {
                                spacing: Theme.spacingS
                                width: parent.width
                                
                                Button {
                                    text: "Düzenle"
                                    icon: Icons.edit
                                    variant: "primary"
                                    height: 36
                                    onClicked: console.log("Edit survey:", modelData.id)
                                }
                                
                                Button {
                                    text: "Sonuçlar"
                                    icon: Icons.barChart
                                    variant: "secondary"
                                    height: 36
                                    onClicked: console.log("View results:", modelData.id)
                                }
                                
                                Button {
                                    text: "Paylaş"
                                    icon: Icons.share
                                    variant: "ghost"
                                    height: 36
                                    onClicked: console.log("Share:", modelData.id)
                                }
                                
                                Item { Layout.fillWidth: true }
                                
                                Button {
                                    text: ""
                                    icon: Icons.trash
                                    variant: "ghost"
                                    height: 36
                                    width: 36
                                    onClicked: console.log("Delete:", modelData.id)
                                }
                            }
                        }
                        
                        MouseArea {
                            id: surveyMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.NoButton
                        }
                    }
                }
            }
        }
    }
    
    // Create Survey Dialog
    Dialog {
        id: createSurveyDialog
        title: "Yeni Anket Oluştur"
        modal: true
        anchors.centerIn: parent
        width: 600
        height: 500
        standardButtons: Dialog.Cancel | Dialog.Save
        
        contentItem: Column {
            spacing: Theme.spacingL
            padding: Theme.spacingXL
            
            Column {
                spacing: Theme.spacingS
                width: parent.width - Theme.spacingXL * 2
                
                Text {
                    text: "Anket Adı *"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSmall
                        weight: Font.DemiBold
                    }
                    color: Theme.gray700
                }
                
                TextField {
                    width: parent.width
                    placeholderText: "Örn: Hipoksi Eğitimi Memnuniyet Anketi"
                    
                    background: Rectangle {
                        radius: Theme.radiusM
                        color: Theme.white
                        border.color: Theme.gray300
                        border.width: 1
                    }
                }
            }
            
            Column {
                spacing: Theme.spacingS
                width: parent.width - Theme.spacingXL * 2
                
                Text {
                    text: "Cihaz Seçimi"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSmall
                        weight: Font.DemiBold
                    }
                    color: Theme.gray700
                }
                
                ComboBox {
                    width: parent.width
                    model: ["Cihaz Seçin...", "Hipoksi Cihazı", "SD Cihazı", "Gece Görüş Lab", "Tüm Cihazlar"]
                    
                    background: Rectangle {
                        radius: Theme.radiusM
                        color: Theme.white
                        border.color: Theme.gray300
                        border.width: 1
                    }
                }
            }
            
            Column {
                spacing: Theme.spacingS
                width: parent.width - Theme.spacingXL * 2
                
                Text {
                    text: "Açıklama"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSmall
                        weight: Font.DemiBold
                    }
                    color: Theme.gray700
                }
                
                TextArea {
                    width: parent.width
                    height: 120
                    placeholderText: "Anket hakkında kısa bir açıklama yazın..."
                    wrapMode: TextArea.WordWrap
                    
                    background: Rectangle {
                        radius: Theme.radiusM
                        color: Theme.white
                        border.color: Theme.gray300
                        border.width: 1
                    }
                }
            }
            
            Column {
                spacing: Theme.spacingS
                width: parent.width - Theme.spacingXL * 2
                
                Text {
                    text: "Anket Şablonu"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSmall
                        weight: Font.DemiBold
                    }
                    color: Theme.gray700
                }
                
                ComboBox {
                    width: parent.width
                    model: ["Boş Anket", "Memnuniyet Anketi Şablonu", "Değerlendirme Anketi Şablonu", "Geri Bildirim Şablonu"]
                    
                    background: Rectangle {
                        radius: Theme.radiusM
                        color: Theme.white
                        border.color: Theme.gray300
                        border.width: 1
                    }
                }
            }
        }
        
        onAccepted: {
            console.log("Create new survey")
        }
    }
}
