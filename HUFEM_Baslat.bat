@echo off
title HUFEM - Hava ve Uzay Fizyolojisi Egitim Merkezi
echo.
echo ============================================
echo   HUFEM v2.0 QML - Baslatiyor...
echo   Saglik Bilimleri Universitesi
echo ============================================
echo.

python main.py

if errorlevel 1 (
    echo.
    echo HATA: Uygulama baslatilirken sorun olustu.
    echo.
    echo Gerekli kutuphaneleri yuklemek icin:
    echo   pip install PySide6 pandas openpyxl
    echo.
    pause
)
