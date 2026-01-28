# HUFEM - Anket Yönetim Sistemi

## Son Güncellemeler (v2.1)

### Yapılan Değişiklikler

#### 1. **Navigasyon Sistemi Yeniden Tasarlandı**
- ✅ Sol sidebar tamamen kaldırıldı
- ✅ Üst navigasyon barı eklendi
- ✅ Tam genişlik sayfa düzeni
- ✅ Modern tab-based navigasyon

#### 2. **İkon Sistemi Güncellendi**
- ✅ Tüm emoji ikonlar iyileştirildi
- ✅ Yeni ikonlar eklendi:
  - 📕 PDF
  - 📗 Excel
  - 💾 Kaydet
  - 🖨️ Yazdır
  - 📤 Paylaş
  - 🔽 Filtrele
  - ⇅ Sırala

#### 3. **PDF Dışa Aktarma Özelliği**
- ✅ Katılımcı listesi PDF export
- ✅ Anket sonuçları PDF export
- ✅ Profesyonel PDF tasarımı:
  - Renkli başlıklar
  - Düzenli tablolar
  - Şirket bilgileri
  - Tarih damgası

#### 4. **Excel Dışa Aktarma Özelliği**
- ✅ Katılımcı listesi Excel export
- ✅ Otomatik kolon genişliği ayarı
- ✅ Renkli başlıklar (mavi arka plan)
- ✅ Kenarlıklı tablolar
- ✅ Merkezi hizalanmış başlıklar

#### 5. **Yeni Sayfalar**

##### Raporlar Sayfası (`ReportsPage.qml`)
- Hızlı dışa aktarma butonları
- Rapor şablonları
- Son oluşturulan raporlar listesi
- PDF ve Excel seçenekleri

##### Anket Yönetimi Sayfası (`SurveysPage.qml`)
- Anket kartları grid görünümü
- Anket oluşturma dialogu
- İstatistik kartları
- Filtreleme ve arama

#### 6. **Ana Sayfa Güncellemeleri**
- Anket odaklı istatistikler
- Anket sonuçları kartları
- Anket aktiviteleri listesi
- Hızlı işlem butonları

## Teknik Detaylar

### Kullanılan Teknolojiler
- **Frontend**: Qt/QML
- **Backend**: Python 3 + PySide6
- **Database**: SQLite3
- **PDF**: ReportLab
- **Excel**: pandas + openpyxl

### Yeni Backend Fonksiyonları

```python
# PDF Export
backend.exportParticipantsToPDF(filename)
backend.exportSurveyResultsToPDF(survey_id, filename)

# Excel Export
backend.exportParticipantsToExcel(filename)
```

### Dosya Yapısı
```
HUFEM/
├── main.py                          # Ana Python backend
├── requirements.txt                 # Bağımlılıklar
├── qml/
│   ├── main.qml                    # Ana pencere
│   ├── components/
│   │   ├── TopNavigation.qml       # ✨ YENİ: Üst navigasyon
│   │   ├── Button.qml
│   │   ├── Card.qml
│   │   ├── StatCard.qml
│   │   └── ...
│   ├── pages/
│   │   ├── DashboardPage.qml       # ✏️ Güncellendi
│   │   ├── ParticipantsPage.qml
│   │   ├── SurveysPage.qml         # ✨ YENİ: Anket yönetimi
│   │   ├── ReportsPage.qml         # ✨ YENİ: Raporlar
│   │   └── ...
│   └── styles/
│       ├── Theme.qml
│       └── Icons.qml                # ✏️ Güncellendi
└── .gitignore                       # ✨ YENİ
```

## Kullanım

### Kurulum
```bash
pip install -r requirements.txt
```

### Çalıştırma
```bash
python main.py
```

### Export Test
```bash
python test_exports.py
```

## Özellikler

### ✅ Tamamlanan
1. Sol sidebar kaldırıldı
2. Üst navigasyon eklendi
3. İkonlar güncellendi
4. PDF export eklendi
5. Excel export eklendi
6. Raporlar sayfası oluşturuldu
7. Anket yönetimi sayfası oluşturuldu
8. Ana sayfa güncellendi

### 🔄 Geliştirilebilir
1. Anket oluşturma wizard'ı
2. Anket doldurma sayfası
3. İstatistik grafikleri
4. Daha fazla rapor şablonu
5. Email ile rapor gönderme
6. Otomatik rapor planlama

## Ekran Görüntüleri

### Ana Sayfa
- Modern üst navigasyon barı
- Anket odaklı istatistikler
- Son anket aktiviteleri
- Hızlı işlem butonları

### Raporlar Sayfası
- Hızlı PDF/Excel export
- Rapor şablonları
- Son oluşturulan raporlar

### Anket Yönetimi
- Grid görünüm
- Anket kartları
- Filtreleme ve arama
- Anket oluşturma dialogu

## Test Sonuçları

```
✅ PDF Export: Başarılı (2.5 KB)
✅ Excel Export: Başarılı (5.4 KB)
✅ Python Syntax: Hatasız
✅ QML Components: Tamamlandı
```

## Lisans
Bu proje Sağlık Bilimleri Üniversitesi HUFEM için geliştirilmiştir.

## Versiyon
**v2.1** - Ocak 2026
