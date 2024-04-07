#!/bin/bash
#
# Example script for Yucca-server on Hikvision cams
# v 0.1 include python bot keys for enable or disable events
# Depend:
# apt-get install inotify-tools
#
check_pack=$(apt-cache policy "inotify-tools" | \
  tr -d '\n' | \
  awk -F' ' \
  '{printf("%s\n\tcurrent version: %s\n\trepo version: %s\n", $1, $3, $5);}'
)

if [ -z "$check_pack" ]; then
  echo "First: install inotify-tools"
  exit 2
fi

# Path to yucca log
log_file=/var/log/yucca.log
# Work DIR
work_dir=/home/user/yucca-tg
# Telegram bot token & user or group chat id
TOKEN=BOT:TOKEN
CHAT_ID="000000000"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
# IP's for yucca-numbered cams Hikvision
cam1="192.168.5.95"

while inotifywait -qqe modify $log_file; do
  # import work flag from file
  source $work_dir/activity.flag
  if [[ $activity_flag -eq "1" ]]; then
    cam_num=$(tail -n 1 $log_file | grep --line-buffered "smtp/session.go:" | sed 's/.*Event //g' | awk -F' ' '{print $4}')
    #MESSAGE="Обнаружено движение на камере $cam_num"
    if [[ -z "$cam_num" ]]; then
        echo "String is not a event. Nothing to do."
        else
          declare -n ipcam=cam$cam_num
          if [[ -z "$ipcam" ]]; then
            echo "Camera not in list. Nothing to do."
          else
            jpg_file=$(wget http://admin:Borisovka_2012@$ipcam/ISAPI/Streaming/channels/101/picture?snapShotImageType=JPEG -O `date +%F-times-%H-%M`.jpg 2>&1 | grep "Сохранение в" --line-buffered | cut -d ' ' -f 3 | sed -e 's/[^A-Za-z0-9._-]//g')
            curl -s -X POST -F media='[{"type":"photo","media":"attach://photo"}]' -F photo=@$jpg_file -H "Content-Type:multipart/form-data" https://api.telegram.org/bot$TOKEN/sendMediaGroup?chat_id=$CHAT_ID
            # rm -f $jpg_file
            #curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE%0A%0A"
          fi
    fi
    else
      echo "Events are OFF. Nothing to do."
  fi
done
