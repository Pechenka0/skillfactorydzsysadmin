#!/usr/bin/env bash
# Мониторинг ресурсов (вариант Б):
# раз в INTERVAL секунд дописывает в monitor.log блок
#   --- ГГГГ-ММ-ДД ЧЧ:ММ:СС ---
#   free -h / df -h / uptime

set -u

INTERVAL=10                              # N секунд между замерами (константа)
LOG_FILE="${LOG_FILE:-monitor.log}"      # куда писать (можно переопределить переменной окружения)
ITERATIONS="${ITERATIONS:-0}"            # сколько замеров сделать; 0 = бесконечно

# --- проверки перед стартом ---
for cmd in free df uptime date; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Ошибка: команда '$cmd' не найдена" >&2
        exit 1
    fi
done

if ! [[ "$ITERATIONS" =~ ^[0-9]+$ ]]; then
    echo "Ошибка: ITERATIONS должно быть целым числом >= 0, получено '$ITERATIONS'" >&2
    exit 1
fi

if ! touch "$LOG_FILE" 2>/dev/null; then
    echo "Ошибка: нет прав на запись в '$LOG_FILE'" >&2
    exit 1
fi

# --- аккуратное завершение по Ctrl+C / docker stop ---
trap 'echo "Мониторинг остановлен"; exit 0' INT TERM

echo "Мониторинг запущен: интервал ${INTERVAL} с, лог ${LOG_FILE}"

count=0
while true; do
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        free -h
        df -h
        uptime
        echo
    } >> "$LOG_FILE"

    count=$((count + 1))
    if [ "$ITERATIONS" -gt 0 ] && [ "$count" -ge "$ITERATIONS" ]; then
        echo "Сделано замеров: $count"
        break
    fi
    sleep "$INTERVAL" &
    wait $!
done
