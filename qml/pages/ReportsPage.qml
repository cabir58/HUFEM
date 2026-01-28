import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import "../styles"
import "../components"

Rectangle {
    id: root
    color: Theme.bgMain
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        // Header
        PageHeader {
            title: "Raporlar"
            subtitle: "PDF ve Excel formatında raporlar oluşturun"
            
            actions: [
                Button {
                    text: "Yenile"
                    icon: Icons.refresh
                    variant: "secondary"
                    onClicked: console.log("Refreshing...")
                }
            ]
        }
        
        // Content
        Flickable {
            width: parent.width
            height: parent.height - 90
            contentHeight: contentColumn.height + Theme.spacingXXL * 2
            clip: true
            
            Column {
                id: contentColumn
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: Theme.spacingXXL
                }
                spacing: Theme.spacingXL
                
                // Quick Export Section
                Rectangle {
                    width: parent.width
                    height: 200
                    radius: Theme.radiusL
                    color: Theme.white
                    border.color: Theme.gray200
                    border.width: 1
                    
                    Column {
                        anchors.fill: parent
                        anchors.margins: Theme.spacingXL
                        spacing: Theme.spacingL
                        
                        Text {
                            text: "🚀 Hızlı Dışa Aktarma"
                            font {
                                family: Theme.fontFamily
                                pixelSize: Theme.fontLarge
                                weight: Font.Bold
                            }
                            color: Theme.gray800
                        }
                        
                        Text {
                            text: "Tüm katılımcı listesini veya anket sonuçlarını hızlıca dışa aktarın"
                            font {
                                family: Theme.fontFamily
                                pixelSize: Theme.fontNormal
                            }
                            color: Theme.gray600
                        }
                        
                        Row {
                            spacing: Theme.spacingM
                            
                            Button {
                                text: "Katılımcılar (PDF)"
                                icon: Icons.pdf
                                variant: "primary"
                                onClicked: exportParticipantsPDF()
                            }
                            
                            Button {
                                text: "Katılımcılar (Excel)"
                                icon: Icons.excel
                                variant: "success"
                                onClicked: exportParticipantsExcel()
                            }
                            
                            Button {
                                text: "Anket Sonuçları (PDF)"
                                icon: Icons.pdf
                                variant: "primary"
                                onClicked: exportSurveyPDF()
                            }
                            
                            Button {
                                text: "Anket Sonuçları (Excel)"
                                icon: Icons.excel
                                variant: "success"
                                onClicked: exportSurveyExcel()
                            }
                        }
                    }
                }
                
                // Report Templates
                Text {
                    text: "📋 Rapor Şablonları"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontLarge
                        weight: Font.Bold
                    }
                    color: Theme.gray800
                }
                
                Row {
                    spacing: Theme.spacingL
                    width: parent.width
                    
                    ReportCard {
                        icon: "👥"
                        title: "Katılımcı Raporu"
                        description: "Tüm katılımcıların detaylı listesi ve istatistikleri"
                        reportType: "participants"
                        onGenerateClicked: (type) => {
                            console.log("Generate:", type)
                        }
                    }
                    
                    ReportCard {
                        icon: "📊"
                        title: "Anket Analizi"
                        description: "Anket sonuçlarının detaylı analizi ve grafikler"
                        reportType: "survey_analysis"
                        onGenerateClicked: (type) => {
                            console.log("Generate:", type)
                        }
                    }
                    
                    ReportCard {
                        icon: "📅"
                        title: "Eğitim Raporu"
                        description: "Dönemlik eğitim aktiviteleri özet raporu"
                        reportType: "training"
                        onGenerateClicked: (type) => {
                            console.log("Generate:", type)
                        }
                    }
                }
                
                // Recent Exports
                Rectangle {
                    width: parent.width
                    height: 400
                    radius: Theme.radiusL
                    color: Theme.white
                    border.color: Theme.gray200
                    border.width: 1
                    
                    Column {
                        anchors.fill: parent
                        spacing: 0
                        
                        // Header
                        Rectangle {
                            width: parent.width
                            height: 56
                            color: "transparent"
                            
                            RowLayout {
                                anchors {
                                    fill: parent
                                    leftMargin: Theme.spacingXL
                                    rightMargin: Theme.spacingXL
                                }
                                
                                Text {
                                    text: "📁 Son Oluşturulan Raporlar"
                                    font {
                                        family: Theme.fontFamily
                                        pixelSize: Theme.fontMedium
                                        weight: Font.DemiBold
                                    }
                                    color: Theme.gray800
                                }
                                
                                Item { Layout.fillWidth: true }
                            }
                            
                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: Theme.gray100
                            }
                        }
                        
                        // List
                        ListView {
                            width: parent.width
                            height: parent.height - 56
                            clip: true
                            
                            model: [
                                {name: "Katılımcı_Listesi_2026-01-28.pdf", date: "28.01.2026 14:30", size: "245 KB", type: "PDF"},
                                {name: "Anket_Sonuclari_54_Donem.xlsx", date: "28.01.2026 12:15", size: "128 KB", type: "Excel"},
                                {name: "Egitim_Raporu_Ocak_2026.pdf", date: "27.01.2026 16:45", size: "512 KB", type: "PDF"},
                                {name: "Katılımcı_Listesi_2026-01-25.xlsx", date: "25.01.2026 10:20", size: "156 KB", type: "Excel"},
                            ]
                            
                            delegate: Rectangle {
                                width: ListView.view.width
                                height: 72
                                color: exportMouse.containsMouse ? Theme.gray50 : "transparent"
                                
                                Behavior on color {
                                    ColorAnimation { duration: 100 }
                                }
                                
                                RowLayout {
                                    anchors {
                                        fill: parent
                                        leftMargin: Theme.spacingXL
                                        rightMargin: Theme.spacingXL
                                    }
                                    spacing: Theme.spacingL
                                    
                                    // Icon
                                    Rectangle {
                                        width: 48
                                        height: 48
                                        radius: Theme.radiusM
                                        color: modelData.type === "PDF" ? Theme.errorLight : Theme.successLight
                                        
                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData.type === "PDF" ? Icons.pdf : Icons.excel
                                            font.pixelSize: 24
                                        }
                                    }
                                    
                                    // Info
                                    Column {
                                        Layout.fillWidth: true
                                        spacing: Theme.spacingXS
                                        
                                        Text {
                                            text: modelData.name
                                            font {
                                                family: Theme.fontFamily
                                                pixelSize: Theme.fontNormal
                                                weight: Font.DemiBold
                                            }
                                            color: Theme.gray800
                                        }
                                        
                                        Row {
                                            spacing: Theme.spacingM
                                            
                                            Text {
                                                text: "📅 " + modelData.date
                                                font {
                                                    family: Theme.fontFamily
                                                    pixelSize: Theme.fontSmall
                                                }
                                                color: Theme.gray500
                                            }
                                            
                                            Text {
                                                text: "💾 " + modelData.size
                                                font {
                                                    family: Theme.fontFamily
                                                    pixelSize: Theme.fontSmall
                                                }
                                                color: Theme.gray500
                                            }
                                        }
                                    }
                                    
                                    // Actions
                                    Row {
                                        spacing: Theme.spacingS
                                        
                                        Button {
                                            text: "Aç"
                                            icon: Icons.eye
                                            variant: "ghost"
                                            height: 36
                                        }
                                        
                                        Button {
                                            text: "İndir"
                                            icon: Icons.download
                                            variant: "secondary"
                                            height: 36
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
                                    id: exportMouse
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
    
    // File dialogs
    FileDialog {
        id: pdfSaveDialog
        fileMode: FileDialog.SaveFile
        nameFilters: ["PDF files (*.pdf)"]
        defaultSuffix: "pdf"
        currentFolder: "file:///" + StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        
        property string reportType: "participants"
        
        onAccepted: {
            var filePath = selectedFile.toString().replace("file:///", "")
            if (reportType === "participants") {
                backend.exportParticipantsToPDF(filePath)
            } else if (reportType === "survey") {
                backend.exportSurveyResultsToPDF(1, filePath)
            }
        }
    }
    
    FileDialog {
        id: excelSaveDialog
        fileMode: FileDialog.SaveFile
        nameFilters: ["Excel files (*.xlsx)"]
        defaultSuffix: "xlsx"
        currentFolder: "file:///" + StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        
        property string reportType: "participants"
        
        onAccepted: {
            var filePath = selectedFile.toString().replace("file:///", "")
            backend.exportParticipantsToExcel(filePath)
        }
    }
    
    // Helper functions
    function exportParticipantsPDF() {
        pdfSaveDialog.reportType = "participants"
        pdfSaveDialog.currentFile = "Katılımcı_Listesi_" + Qt.formatDateTime(new Date(), "yyyy-MM-dd") + ".pdf"
        pdfSaveDialog.open()
    }
    
    function exportParticipantsExcel() {
        excelSaveDialog.reportType = "participants"
        excelSaveDialog.currentFile = "Katılımcı_Listesi_" + Qt.formatDateTime(new Date(), "yyyy-MM-dd") + ".xlsx"
        excelSaveDialog.open()
    }
    
    function exportSurveyPDF() {
        pdfSaveDialog.reportType = "survey"
        pdfSaveDialog.currentFile = "Anket_Sonuçları_" + Qt.formatDateTime(new Date(), "yyyy-MM-dd") + ".pdf"
        pdfSaveDialog.open()
    }
    
    function exportSurveyExcel() {
        // Implement survey Excel export
        console.log("Export survey to Excel")
    }
    
    // Report Card Component
    component ReportCard: Rectangle {
        property string icon: ""
        property string title: ""
        property string description: ""
        property string reportType: ""
        
        signal generateClicked(string type)
        
        width: (parent.width - Theme.spacingL * 2) / 3
        height: 220
        radius: Theme.radiusL
        color: Theme.white
        border.color: Theme.gray200
        border.width: 1
        
        Column {
            anchors {
                fill: parent
                margins: Theme.spacingXL
            }
            spacing: Theme.spacingL
            
            Text {
                text: icon
                font.pixelSize: 48
            }
            
            Column {
                spacing: Theme.spacingS
                width: parent.width
                
                Text {
                    text: title
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontMedium
                        weight: Font.Bold
                    }
                    color: Theme.gray800
                    width: parent.width
                    wrapMode: Text.WordWrap
                }
                
                Text {
                    text: description
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSmall
                    }
                    color: Theme.gray600
                    width: parent.width
                    wrapMode: Text.WordWrap
                }
            }
            
            Item { height: Theme.spacingS }
            
            Row {
                spacing: Theme.spacingS
                
                Button {
                    text: "PDF"
                    icon: Icons.pdf
                    variant: "primary"
                    height: 36
                    onClicked: generateClicked(reportType + "_pdf")
                }
                
                Button {
                    text: "Excel"
                    icon: Icons.excel
                    variant: "success"
                    height: 36
                    onClicked: generateClicked(reportType + "_excel")
                }
            }
        }
    }
}
