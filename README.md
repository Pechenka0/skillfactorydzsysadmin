# skillfactorydzsysadmin

`script.sh` — мониторинг ресурсов: раз в 10 секунд дописывает в `monitor.log` блок с временной меткой и выводом `free -h`, `df -h`, `uptime`.

```bash
./script.sh                # бесконечно, Ctrl+C для остановки
ITERATIONS=3 ./script.sh   # 3 замера и выход
```

Пример вывода — `sample_output.txt`.
