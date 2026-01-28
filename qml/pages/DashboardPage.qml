import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../styles"
import "../components"

Rectangle {
    id: root
    color: Theme.bgMain
    
    // Stats data (will be populated from Python backend)
    property int totalParticipants: 156
    property int activeGroups: 4
    property int totalSessions: 324
    property int sessionsThisMonth: 28
    
    property int hypoxiaCount: 142
    property int sdCount: 98
    property int nvgCount: 84
    
    Column {
        anchors.fill: parent
        spacing: 0
        
        // Header
        PageHeader {
            title: "Dashboard"
            subtitle: "HUFEM • Eğitim Merkezi Genel Görünümü"
            
            actions: [
                Button {
                    text: "Rapor Oluştur"
                    icon: Icons.fileText
                    variant: "secondary"
                },
                Button {
                    text: "Yenile"
                    icon: Icons.refresh
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
                spacing: Theme.spacingXXL
                
                // Stats row
                Row {
                    spacing: Theme.spacingL
                    
                    StatCard {
                        icon: "👥"
                        value: totalParticipants.toString()
                        label: "Toplam Katılımcı"
                        accentColor: Theme.primary
                        trend: "+12%"
                        trendUp: true
                    }
                    
                    StatCard {
                        icon: "📁"
                        value: activeGroups.toString()
                        label: "Aktif Dönem"
                        accentColor: Theme.secondary
                    }
                    
                    StatCard {
                        icon: "📅"
                        value: totalSessions.toString()
                        label: "Toplam Eğitim"
                        accentColor: Theme.success
                        trend: "+8%"
                        trendUp: true
                    }
                    
                    StatCard {
                        icon: "📊"
                        value: sessionsThisMonth.toString()
                        label: "Bu Ay"
                        accentColor: Theme.warning
                    }
                }
                
                // Section title
                Text {
                    text: "Cihaz Bazlı Eğitimler"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontMedium
                        weight: Font.DemiBold
                    }
                    color: Theme.gray800
                }
                
                // Device cards
                Row {
                    spacing: Theme.spacingL
                    
                    DeviceCard {
                        icon: "🫁"
                        title: "Hipoksi Eğitim Cihazı"
                        subtitle: "Hipoksik ortam simülasyonu"
                        count: hypoxiaCount.toString()
                        accentColor: Theme.hypoxia
                    }
                    
                    DeviceCard {
                        icon: "🔄"
                        title: "SD Eğitim Cihazı"
                        subtitle: "Mekansal dezoryantasyon"
                        count: sdCount.toString()
                        accentColor: Theme.sd
                    }
                    
                    DeviceCard {
                        icon: "🌙"
                        title: "Gece Görüş Lab"
                        subtitle: "NVG eğitim laboratuvarı"
                        count: nvgCount.toString()
                        accentColor: Theme.nvg
                    }
                }
                
                // Recent sessions card
                Rectangle {
                    width: parent.width
                    height: 380
                    radius: Theme.radiusL
                    color: Theme.white
                    border.color: Theme.gray200
                    border.width: 1
                    
                    Column {
                        anchors.fill: parent
                        spacing: 0
                        
                        // Card header
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
                                    text: "📋 Son Eğitimler"
                                    font {
                                        family: Theme.fontFamily
                                        pixelSize: Theme.fontMedium
                                        weight: Font.DemiBold
                                    }
                                    color: Theme.gray800
                                }
                                
                                Item { Layout.fillWidth: true }
                                
                                Button {
                                    text: "Tümünü Gör"
                                    variant: "ghost"
                                    height: 32
                                }
                            }
                            
                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: Theme.gray100
                            }
                        }
                        
                        // Table
                        DataTable {
                            width: parent.width
                            height: parent.height - 56
                            headers: ["Tarih", "Dönem", "Cihaz", "Katılımcı", "Gözetmen", "Durum"]
                            columnWidths: [120, 150, 180, 100, 150, 120]
                            data: [
                                {tarih: "28.01.2026", donem: "54. Dönem", cihaz: "Hipoksi Cihazı", katilimci: "12", gozetmen: "Dr. Yılmaz", durum: "✓ Tamamlandı"},
                                {tarih: "27.01.2026", donem: "53. Dönem", cihaz: "SD Cihazı", katilimci: "8", gozetmen: "Dr. Kaya", durum: "✓ Tamamlandı"},
                                {tarih: "27.01.2026", donem: "54. Dönem", cihaz: "Gece Görüş Lab", katilimci: "15", gozetmen: "Dr. Demir", durum: "✓ Tamamlandı"},
                                {tarih: "26.01.2026", donem: "52. Dönem", cihaz: "Hipoksi Cihazı", katilimci: "10", gozetmen: "Dr. Yılmaz", durum: "✓ Tamamlandı"},
                                {tarih: "25.01.2026", donem: "53. Dönem", cihaz: "SD Cihazı", katilimci: "14", gozetmen: "Dr. Kaya", durum: "✓ Tamamlandı"},
                            ]
                        }
                    }
                }
                
                // Quick actions
                Rectangle {
                    width: parent.width
                    height: 100
                    radius: Theme.radiusL
                    color: Theme.white
                    border.color: Theme.gray200
                    border.width: 1
                    
                    Row {
                        anchors.centerIn: parent
                        spacing: Theme.spacingL
                        
                        Button {
                            text: "Yeni Dönem Oluştur"
                            icon: "📁"
                        }
                        
                        Button {
                            text: "Eğitim Başlat"
                            icon: "▶"
                            variant: "success"
                        }
                        
                        Button {
                            text: "Anket Doldur"
                            icon: "✏"
                            variant: "secondary"
                        }
                        
                        Button {
                            text: "Rapor Oluştur"
                            icon: "📄"
                            variant: "secondary"
                        }
                    }
                }
            }
        }
    }
}
