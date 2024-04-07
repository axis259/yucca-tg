#!/bin/bash
# Path to 'activity.flag'
source /home/axis/yucca-tg/activity.flag
case $activity_flag in
1)
echo "Статус оповещения: Включено." ;;
0)
echo "Статус оповещения: Отключено." ;;
*) echo "Ошибка" ;;
esac
