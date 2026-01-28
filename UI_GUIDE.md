# HUFEM UI/UX Değişiklikleri

## Önceki Tasarım vs Yeni Tasarım

### 1. Navigasyon Sistemi

#### ÖNCE: Sol Sidebar
```
┌──────────────────────────────────────┐
│ SIDEBAR │ CONTENT                    │
│ (260px) │                            │
│         │                            │
│ 🏥      │                            │
│ HUFEM   │                            │
│         │                            │
│ GENEL   │                            │
│ • Ana   │                            │
│ • Kat.  │                            │
│ • Dön.  │                            │
│         │                            │
│ ANKET   │                            │
│ • Yön.  │                            │
│ • Dol.  │                            │
└──────────────────────────────────────┘
```

#### ŞİMDİ: Üst Navigasyon
```
┌──────────────────────────────────────┐
│ 🏥 HUFEM │ Ana│Kat│Ank│Dol│Rap│ 🔔⚙️│
├──────────────────────────────────────┤
│                                      │
│     FULL WIDTH CONTENT               │
│                                      │
│                                      │
│                                      │
│                                      │
│                                      │
└──────────────────────────────────────┘
```

### 2. Ana Sayfa İstatistikleri

#### ÖNCE: Eğitim Odaklı
```
┌─────────────────┬─────────────────┐
│ 👥 156          │ 📁 4            │
│ Katılımcı       │ Dönem           │
└─────────────────┴─────────────────┘
┌─────────────────┬─────────────────┐
│ 📅 324          │ 📊 28           │
│ Eğitim          │ Bu Ay           │
└─────────────────┴─────────────────┘
```

#### ŞİMDİ: Anket Odaklı
```
┌─────────────────┬─────────────────┐
│ 👥 156          │ 📋 12           │
│ Katılımcı       │ Anket           │
└─────────────────┴─────────────────┘
┌─────────────────┬─────────────────┐
│ ✅ 583          │ 📊 94%          │
│ Yanıt           │ Tamamlama       │
└─────────────────┴─────────────────┘
```

### 3. İkon Sistemi

#### Yeni İkonlar
```
📕 PDF       - PDF dosyaları için
📗 Excel     - Excel dosyaları için
💾 Kaydet    - Kaydetme işlemleri için
🖨️ Yazdır    - Yazdırma için
📤 Paylaş    - Paylaşım için
🔽 Filtre    - Filtreleme için
⇅ Sırala     - Sıralama için
✅ Başarı    - Tamamlanan işlemler
⏳ Bekliyor  - Devam eden işlemler
```

### 4. Yeni Sayfalar

#### Raporlar Sayfası
```
┌──────────────────────────────────────┐
│ Raporlar                             │
├──────────────────────────────────────┤
│ 🚀 Hızlı Dışa Aktarma                │
│ ┌──────────┬──────────┬──────────┐  │
│ │ Kat. PDF │ Kat. XLS │ Ank. PDF │  │
│ └──────────┴──────────┴──────────┘  │
│                                      │
│ 📋 Rapor Şablonları                  │
│ ┌──────────┬──────────┬──────────┐  │
│ │ 👥 Kat.  │ 📊 Analiz│ 📅 Eğitim│  │
│ │ Raporu   │ Raporu   │ Raporu   │  │
│ │ PDF/XLS  │ PDF/XLS  │ PDF/XLS  │  │
│ └──────────┴──────────┴──────────┘  │
│                                      │
│ 📁 Son Oluşturulan Raporlar          │
│ • Katılımcı_Listesi_2026-01-28.pdf   │
│ • Anket_Sonuclari_54_Donem.xlsx      │
└──────────────────────────────────────┘
```

#### Anket Yönetimi Sayfası
```
┌──────────────────────────────────────┐
│ Anket Yönetimi          [+ Yeni]     │
├──────────────────────────────────────┤
│ ┌────┬────┬────┬────┐               │
│ │📋4 │✅583│👥156│📊94%│             │
│ └────┴────┴────┴────┘               │
│                                      │
│ [Ara...] [Filtre] [Cihaz]           │
│                                      │
│ ┌──────────────┬──────────────┐     │
│ │ 📋 Hipoksi   │ 📋 SD Eğitimi│     │
│ │ Anketi       │ Anketi       │     │
│ │ 12 Soru      │ 15 Soru      │     │
│ │ 156 Yanıt    │ 98 Yanıt     │     │
│ │ [Düz][Son]   │ [Düz][Son]   │     │
│ └──────────────┴──────────────┘     │
│ ┌──────────────┬──────────────┐     │
│ │ 📋 Gece Görüş│ 📋 Genel     │     │
│ │ Anketi       │ Anket        │     │
│ │ 10 Soru      │ 8 Soru       │     │
│ │ 84 Yanıt     │ 245 Yanıt    │     │
│ │ [Düz][Son]   │ [Düz][Son]   │     │
│ └──────────────┴──────────────┘     │
└──────────────────────────────────────┘
```

## Renk Paleti

### Ana Renkler
- **Primary**: #6366F1 (İndigo)
- **Success**: #22C55E (Yeşil)
- **Warning**: #F59E0B (Turuncu)
- **Error**: #EF4444 (Kırmızı)

### Cihaz Renkleri
- **Hipoksi**: #F59E0B (Turuncu)
- **SD**: #8B5CF6 (Mor)
- **Gece Görüş**: #10B981 (Yeşil)

### Nötr Renkler
- **Beyaz**: #FFFFFF
- **Gri 50**: #F9FAFB
- **Gri 800**: #1F2937
- **Gri 900**: #111827

## Animasyonlar

- **Hızlı**: 150ms (hover efektleri)
- **Normal**: 250ms (geçişler)
- **Yavaş**: 400ms (büyük değişiklikler)

## Tipografi

- **Font**: Segoe UI
- **Tiny**: 10px
- **Small**: 12px
- **Normal**: 14px
- **Medium**: 16px
- **Large**: 20px
- **XLarge**: 24px

## Boşluklar

- **XS**: 4px
- **S**: 8px
- **M**: 12px
- **L**: 16px
- **XL**: 24px
- **XXL**: 32px
- **Huge**: 48px

## Kenar Yuvarlaklığı

- **S**: 6px
- **M**: 8px
- **L**: 12px
- **XL**: 16px

## Buton Varyantları

### Primary (Mavi)
```
┌──────────────┐
│ ✏️ Düzenle   │
└──────────────┘
```

### Success (Yeşil)
```
┌──────────────┐
│ ✅ Kaydet    │
└──────────────┘
```

### Secondary (Gri)
```
┌──────────────┐
│ 📤 Paylaş    │
└──────────────┘
```

### Ghost (Şeffaf)
```
┌──────────────┐
│ 👁️ Görüntüle │
└──────────────┘
```

## Responsive Tasarım

### Minimum Boyutlar
- **Genişlik**: 1024px
- **Yükseklik**: 768px

### Önerilen Boyutlar
- **Genişlik**: 1440px
- **Yükseklik**: 900px

## Erişilebilirlik

- ✅ Yüksek kontrast renkler
- ✅ Anlamlı ikonlar
- ✅ Tooltip'ler
- ✅ Klavye navigasyonu
- ✅ Büyük tıklanabilir alanlar (min 32px)
