#!/bin/bash
# Скрипт проверяет объём кэша в оперативной памяти и при превышении в 1Gb предлагает запустить очистку

cache=$(free -m | grep Mem | awk '{print $6}')

echo "Кэшированно $cacheМб"

if [ $cache -ge 1000 ]
then
	echo "Кэш более одного гигабайта"
	echo ""
	read -p "Почистить кэш? Y/n: " ansver
		case $ansver in
		[y,Y])
			echo "Для запуска скрипта очистки, введите пароль SUDO пользователя"
			sudo echo "Было занято в кеше ОЗУ"
			free -m
			sync
			echo 1 | sudo tee -a /proc/sys/vm/drop_caches
			sync
			echo 2 | sudo tee -a /proc/sys/vm/drop_caches
			sync
			echo 3 | sudo tee -a /proc/sys/vm/drop_caches
			echo "Стало свободно в ОЗУ"
			free -m;;
		[n,N])
			echo "Вы отказались от чистки кэша";;
		esac
else
	echo "Достаточно свободной памяти"
fi
