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
                        icon: Icons.users
                        value: totalParticipants.toString()
                        label: "Toplam Katılımcı"
                        accentColor: Theme.primary
                        trend: "+12%"
                        trendUp: true
                    }
                    
                    StatCard {
                        icon: Icons.clipboard
                        value: "12"
                        label: "Aktif Anket"
                        accentColor: Theme.secondary
                    }
                    
                    StatCard {
                        icon: Icons.check
                        value: "583"
                        label: "Toplam Yanıt"
                        accentColor: Theme.success
                        trend: "+8%"
                        trendUp: true
                    }
                    
                    StatCard {
                        icon: Icons.barChart
                        value: "94%"
                        label: "Tamamlama Oranı"
                        accentColor: Theme.warning
                    }
                }
                
                // Section title
                Text {
                    text: "📋 Son Anket Sonuçları"
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontMedium
                        weight: Font.DemiBold
                    }
                    color: Theme.gray800
                }
                
                // Survey results cards
                Row {
                    spacing: Theme.spacingL
                    
                    DeviceCard {
                        icon: Icons.clipboard
                        title: "Hipoksi Eğitimi Anketi"
                        subtitle: "156 katılımcı yanıtladı"
                        count: "4.8/5.0"
                        accentColor: Theme.hypoxia
                    }
                    
                    DeviceCard {
                        icon: Icons.clipboard
                        title: "SD Eğitimi Anketi"
                        subtitle: "98 katılımcı yanıtladı"
                        count: "4.6/5.0"
                        accentColor: Theme.sd
                    }
                    
                    DeviceCard {
                        icon: Icons.clipboard
                        title: "Gece Görüş Anketi"
                        subtitle: "84 katılımcı yanıtladı"
                        count: "4.9/5.0"
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
                                    text: Icons.clipboard + " Son Anket Aktiviteleri"
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
                            headers: ["Tarih", "Anket", "Katılımcı", "Yanıt Sayısı", "Tamamlama", "Durum"]
                            columnWidths: [120, 250, 150, 120, 120, 120]
                            data: [
                                {tarih: "28.01.2026", donem: "Hipoksi Eğitimi Anketi", cihaz: "Ali Yılmaz", katilimci: "12/12", gozetmen: "100%", durum: "✅ Tamamlandı"},
                                {tarih: "27.01.2026", donem: "SD Eğitimi Anketi", cihaz: "Ayşe Kaya", katilimci: "10/15", gozetmen: "67%", durum: "⏳ Devam Ediyor"},
                                {tarih: "27.01.2026", donem: "Gece Görüş Anketi", cihaz: "Mehmet Demir", katilimci: "15/15", gozetmen: "100%", durum: "✅ Tamamlandı"},
                                {tarih: "26.01.2026", donem: "Hipoksi Eğitimi Anketi", cihaz: "Fatma Çelik", katilimci: "8/12", gozetmen: "67%", durum: "⏳ Devam Ediyor"},
                                {tarih: "25.01.2026", donem: "SD Eğitimi Anketi", cihaz: "Can Öztürk", katilimci: "14/15", gozetmen: "93%", durum: "✅ Tamamlandı"},
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
                            text: "Yeni Anket Oluştur"
                            icon: Icons.plus
                        }
                        
                        Button {
                            text: "Anket Doldur"
                            icon: Icons.edit
                            variant: "success"
                        }
                        
                        Button {
                            text: "Sonuçları Görüntüle"
                            icon: Icons.barChart
                            variant: "secondary"
                        }
                        
                        Button {
                            text: "Rapor Oluştur"
                            icon: Icons.pdf
                            variant: "secondary"
                        }
                    }
                }
            }
        }
    }
}
