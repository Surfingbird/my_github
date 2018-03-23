#README.MD

3.4 Пишем предельно простой скрипт.
Его задача - раз в минуту копировать содержимое из
/proc/mdstat
в
/home/checker/data/mdstat

Создаём
/home/checker/bin/mdstat-logger.sh
Пишем нужные команды в нужном виде,
выставляем нужные права (на запуск),
запуск данного скрипта прописываем в крон или systemd.timer.
Скрипт должен работать от имени checker.
(см. cron, systemd timer)


3.5 Пишем скрипт логирования утилизации диска. Пишем, используя bash и iostat
Создаём его в
/home/checker/bin/iostat-logger.sh
Нас интересует общая утилизация (util%) диска vda. (см. iostat)
Скрипт должен каждую минуту дописывать в файл
/home/checker/data/iostat-logger.log
в формате
YYMMDDHHMMSS NN
статистику общей утилизации диска.
Время сбора утилизации допустимо выбрать в промежутке от 15 до 60 секунд.
Интервал записи = ровно 1 минута.

Работать скрипт должен от имени пользователя "checker".
Запуск скрипта настроить через crontab.
(см. crontab)

Полезные ссылки: https://linoxide.com/linux-command/linux-iostat-command/ https://stackoverflow.com/questions/20217145/parse-iostat-output https://rtfm.co.ua/linux-opisanie-utility-iostat/ https://habrahabr.ru/post/165855/


3.6. Настраиваем ротирование лога.
Файл iostat-logger.log будет бесконечно расти, если с этим ничего не сделать.
Это надо исправить посредством logrotate.
Пишем конфиг
/etc/logrotate.d/iostat-logger
Требования
- ротироваться ежедневно
- храним текущий и крайних 5 логов
- сжимаем
- не должно меняться других файлов в директории /home/checker/data/
- должны сохраняться владелец и группа файлов

(см logrotate, crontab)

Проверить работу logrotate можно запустив его вручную от рута и форсировав его запуск флагом -f

PS: Сделать ротирование внутри iostat-logger.sh можно. Только зачем? Есть logrotate.


3.7. Лог - хорошо, но мало. Пишем "алертер".
/home/checker/bin/iostat-alerter.sh
Скрипт должен просматривать все файлы логов iostat-logger-а, в том числе (ротированые и) пожатые,
после каждого запуска должен формировать (с замещением) файл
/home/checker/data/iostat-alerts
, содержащий в себе периоды, когда утилизация была >50%.
Формат:
YYMMDDHHMMSS-YYMMDDHHMMSS

Настроить запуск раз в 10 минут через systemd.timer, при наличии в системе systemd, или через крон.
