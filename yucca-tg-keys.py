#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
import telebot
from telebot import types
# Your BOT Token
bot = telebot.TeleBot('BOT:TOKEN', threaded=False)
# Working dir
work_dir = "/path/to/yucca-tg"

@bot.message_handler(content_types=['text'])
def inline_key(a):
    if a.text == "/start":
        mainmenu = types.InlineKeyboardMarkup()
        getstat = subprocess.check_output('./yucca-tg-stat.sh', shell=True, cwd=work_dir)
        key1 = types.InlineKeyboardButton(text='Включить оповещение', callback_data='key1')
        key2 = types.InlineKeyboardButton(text='Отключить оповещение', callback_data='key2')
        mainmenu.add(key1, key2)
        bot.send_message(a.chat.id, getstat, reply_markup=mainmenu)

@bot.callback_query_handler(func=lambda call: True)
def callback_inline(call):
    if call.data == "mainmenu":
        mainmenu1 = types.InlineKeyboardMarkup()
        key1 = types.InlineKeyboardButton(text='Включить оповещение', callback_data='key1')
        key2 = types.InlineKeyboardButton(text='Отключить оповещение', callback_data='key2')
        mainmenu1.add(key1, key2)
        bot.edit_message_reply_markup(call.message.chat.id, call.message.message_id, reply_markup=mainmenu1)
    elif call.data == "key1":
        next_menu = types.InlineKeyboardMarkup()
        set_on = subprocess.check_output('echo "activity_flag="1"" > activity.flag && ./yucca-tg-stat.sh', shell=True, cwd=work_dir)
        back = types.InlineKeyboardButton(text='Назад', callback_data='mainmenu')
        next_menu.add(back)
        bot.edit_message_text(set_on, call.message.chat.id, call.message.message_id, reply_markup=next_menu)
    elif call.data == "key2":
        next_menu2 = types.InlineKeyboardMarkup()
        set_off = subprocess.check_output('echo "activity_flag="0"" > activity.flag && ./yucca-tg-stat.sh', shell=True, cwd=work_dir)
        back = types.InlineKeyboardButton(text='Назад', callback_data='mainmenu')
        next_menu2.add(back)
        bot.edit_message_text(set_off, call.message.chat.id, call.message.message_id, reply_markup=next_menu2)
bot.polling()
