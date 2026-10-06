@echo off
chcp 65001 >nul
setlocal

set "PROJECT_ROOT=%~dp0.."
set "MAIN_PY=%PROJECT_ROOT%\src\main.py"

echo === Тест 1: интерактивный режим с вводом команд через pipe ===
(
echo ls
echo cd /tmp
echo exit
) | python "%MAIN_PY%" --vfs testvfs --debug

echo.
echo === Тест 2: выполнение стартового скрипта commands_errpr.txt ===
python "%MAIN_PY%" --vfs testvfs --startup "%PROJECT_ROOT%\scripts\commands_error.txt" --debug

echo.
echo === Тест 3: выполнение стартового скрипта commands.txt (с ошибками) ===
python "%MAIN_PY%" --vfs testvfs --startup "%PROJECT_ROOT%\scripts\commands.txt" --debug

echo.
echo === Тестирование завершено ===
pause