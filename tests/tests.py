import os
import subprocess
import sys

import pytest

SRC_DIR = os.path.join(os.path.dirname(__file__), "..", "src")
sys.path.insert(0, os.path.abspath(SRC_DIR))

from shell_emulator import ShellEmulator


def test_parse_input_quotes():
    emu = ShellEmulator()
    result = emu.parse_input('ls "file with spaces.txt"')
    assert result == ["ls", "file with spaces.txt"]


def test_cmd_ls(capsys):
    emu = ShellEmulator()
    emu.cmd_ls([])
    captured = capsys.readouterr()
    assert "Команда: ls" in captured.out
    assert "Аргументы отсутствуют" in captured.out


def test_cmd_cd_no_args(capsys):
    emu = ShellEmulator()
    emu.cmd_cd([])
    captured = capsys.readouterr()
    assert "Команда: cd" in captured.out
    assert "Аргументы отсутствуют" in captured.out


def test_unknown_command(capsys):
    emu = ShellEmulator()
    result = emu.execute_command("unknown", [])
    captured = capsys.readouterr()
    assert result is False
    assert "неизвестная команда" in captured.out


def test_script_execution(tmp_path, capsys):
    script = tmp_path / "test.txt"
    script.write_text("ls\ncd /tmp\nexit\n", encoding="utf-8")

    emu = ShellEmulator(script_mode=True)
    result = emu.execute_script(str(script))
    captured = capsys.readouterr()

    assert result is True
    assert "=== ВЫПОЛНЕНИЕ СКРИПТА" in captured.out
    assert "Успешных команд: 3" in captured.out