@echo off
chcp 1254 >nul
color 0A

:: =====================================================
::  ADMIN DEGILSE KENDINI ADMIN OLARAK YENIDEN AÇ
:: =====================================================
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    cls
    echo ================================================
    echo     Bu arac yonetici yetkisi gerektiriyor.
    echo   Yonetici haklariyla yeniden baslatiliyor...
    echo ================================================
    echo.
    echo   This tool requires administrator privileges.
    echo         Restarting with admin rights...
    echo.

    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: =====================================================
::  DIL SEÇIMI
:: =====================================================

:DIL_SEC
cls
echo ================================================
echo       Dil Seciniz / Select Language
echo ================================================
echo.
echo   1) Türkçe
echo   2) English
echo.
set /p dil=Secim / Choice (1-2): 

if "%dil%"=="1" goto TR_MENU
if "%dil%"=="2" goto EN_MENU
goto DIL_SEC


:: ===========================
:: TÜRKÇE MENÜ
:: ===========================

:TR_MENU
cls
title Hiberfil.sys Yönetim Araci Menüsü - Olusturan AKSENFONI
echo ================================================================
echo                 Hiberfil.sys Yönetim Araci Menüsü
echo                         Olusturan AKSENFONI
echo ================================================================
echo.
echo   1) Hiberfil.sys güncel boyutu ve durumunu göster
echo   2) Hiberfil.sys silinsin + Hibernation ve Hizli Baslatmayi kapat
echo   3) Uygulamayi kapat
echo.
set /p secim=Seçiminiz (1-3): 

if "%secim%"=="1" goto TR_DURUM
if "%secim%"=="2" goto TR_KAPAT
if "%secim%"=="3" goto CIKIS
goto TR_MENU


:TR_DURUM
cls
echo ================================================================
echo            Hiberfil.sys Durum ve Boyut Kontrolü
echo ================================================================
echo.

if exist "C:\hiberfil.sys" (
    for %%A in ("C:\hiberfil.sys") do set SIZE=%%~zA
    echo Hiberfil.sys bulundu.
    echo Dosya Konumu : C:\hiberfil.sys
    echo Dosya Boyutu : %SIZE% bayt
) else (
    echo Hiberfil.sys bulunamadi veya zaten devre disi.
)

echo.
pause
goto TR_MENU


:TR_KAPAT
cls
echo ================================================================
echo   Hiberfil.sys Silme + Hibernation / Hizli Baslatma Kapatma
echo ================================================================
echo.

echo Hibernation kapatiliyor...
powercfg -h off

echo.
echo Hizli Baslatma kapatiliyor...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f

echo.
echo Islemler tamamlandi.
echo.
pause
goto TR_MENU


:: ===========================
:: ENGLISH MENU
:: ===========================

:EN_MENU
cls
title Hiberfil.sys Management Menu - Created by ChatGPT
echo ================================================================
echo                   Hiberfil.sys Management Menu
echo ================================================================
echo.
echo   1) Show current size and status of Hiberfil.sys
echo   2) Delete Hiberfil.sys + Disable Hibernation and Fast Startup
echo   3) Exit application
echo.
set /p secim=Choice (1-3): 

if "%secim%"=="1" goto EN_STATUS
if "%secim%"=="2" goto EN_DISABLE
if "%secim%"=="3" goto CIKIS
goto EN_MENU


:EN_STATUS
cls
echo ================================================================
echo           Hiberfil.sys Status and Size Check
echo ================================================================
echo.

if exist "C:\hiberfil.sys" (
    for %%A in ("C:\hiberfil.sys") do set SIZE=%%~zA
    echo Hiberfil.sys found.
    echo File Location : C:\hiberfil.sys
    echo File Size     : %SIZE% bytes
) else (
    echo Hiberfil.sys is not found or already disabled.
)

echo.
pause
goto EN_MENU


:EN_DISABLE
cls
echo ================================================================
echo    Deleting Hiberfil.sys + Turning Off Hibernation / Fast Startup
echo ================================================================
echo.

echo Disabling Hibernation...
powercfg -h off

echo.
echo Disabling Fast Startup...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f

echo.
echo Actions completed.
echo.
pause
goto EN_MENU


:CIKIS
exit
