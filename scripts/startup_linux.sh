#!/usr/bin/env bash

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAIN_PY="$PROJECT_ROOT/src/main.py"

echo "=== Тест 1: интерактивный режим с вводом команд через pipe ==="
echo -e "ls\ncd /tmp\nexit\n" | python3 "$MAIN_PY" --vfs testvfs --debug

echo -e "\n=== Тест 2: выполнение стартового скрипта commands_errpr.txt ==="
python3 "$MAIN_PY" --vfs testvfs --startup "$PROJECT_ROOT/scripts/commands_errpr.txt" --debug

echo -e "\n=== Тест 3: выполнение стартового скрипта commands.txt (с ошибками) ==="
python3 "$MAIN_PY" --vfs testvfs --startup "$PROJECT_ROOT/scripts/commands.txt" --debug

echo -e "\n=== Тестирование завершено ==="
read -p "Press any key to continue . . ."