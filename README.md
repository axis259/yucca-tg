# Yucca-TG

Примеры скриптов для обработки ивентов от сервера видеофиксации Yucca.
Реализует функционал отправки скриншота в мессенджер Telegram при обнаружении движения.
Подходит для некоммерческого использования.

## Установка

Пример для Debian Bookworm
yucca = 0.10
python = 3.11

```shell
git clone https://github.com/axis259/yucca-tg
```

Для работы yucca-tg.sh
```shell
sudo apt-get install inotify-tools
```

Для работы yucca-tg-keys.py в своем venv
```shell
pip install pytelegrambotapi
```

Включить логгирование в конфиге сервера.

Вставить свои параметры:
В shell скрипте 'yucca-tg.sh', используется для отлова ивентов из лога.

Путь к логам.

'log_file=/var/log/yucca.log'

Рабочая директория.

'work_dir=/home/user/yucca-tg'

Токен бота Telegram.

'TOKEN=BOT:TOKEN'

ID чата, куда отправлять скриншоты.

'CHAT_ID="000000000"'

Создать свой список камер в формате:

'cam1="192.168.5.95"'

cam - префикс к порядковому номеру камеры, присвоенному сервером. Можно увидеть на вкладке "Детекция движения по Email" в настройках камеры.

В shell скрипте 'yucca-tg-stat.sh', используется для отображения статуса работы оповещения.

Изменить путь к файлу

'source /home/axis/yucca-tg/activity.flag'

В python скрипте 'yucca-tg-keys.py', создает кнопки от бота для включения/отключения оповещения.

Токен бота Telegram.

'bot = telebot.TeleBot('BOT:TOKEN', threaded=False)'

Рабочая директория.

'work_dir = "/path/to/yucca-tg"'

Файлы yucca-tg.service, yucca-tg-keys.service для примера запуска сервисов через systemd.

Скрипт yucca-tg-keys.sh для запуска python скрипта в venv.
