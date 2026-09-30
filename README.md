# skillfactorydzsysadmin

`script.sh` — мониторинг ресурсов: раз в 10 секунд дописывает в `monitor.log` блок с временной меткой и выводом `free -h`, `df -h`, `uptime`.

## Запуск

```bash
./script.sh                   # бесконечно, Ctrl+C для остановки
ITERATIONS=3 ./script.sh      # сделать 3 замера и выйти
LOG_FILE=/tmp/m.log ./script.sh
```

Пример вывода — `sample_output.txt`.

## Структура

| Файл | Что это |
|---|---|
| `script.sh` | скрипт мониторинга |
| `sample_output.txt` | пример содержимого `monitor.log` |
| `Dockerfile` | образ: скрипт + HTTP-сервер на 8080, отдаёт `monitor.log` |
| `docker-compose.yml` | запуск через `docker compose up` |
| `nginx/my-app.conf` | reverse proxy 80→443→127.0.0.1:8080, self-signed TLS |
| `systemd/my-app.service` | unit-файл, поднимает контейнер `my-app` при загрузке |
