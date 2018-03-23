#!/bin/bash

echo "#This is ALERTS!!!" > /home/checker/data/iostat-alerts
perl /home/checker/bin/perl_alerter.pl /home/checker/data/iostat-logger.log /home/checker/data/iostat-alerts

chmod 711 /home/checker/data/iostat-logger.log.*

gunzip -d /home/checker/data/iostat-logger.log.1.gz
perl /home/checker/bin/perl_alerter.pl /home/checker/data/iostat-logger.log.1 /home/checker/data/iostat-alerts
gzip /home/checker/data/iostat-logger.log.1

gunzip -d /home/checker/data/iostat-logger.log.2.gz
perl /home/checker/bin/perl_alerter.pl /home/checker/data/iostat-logger.log.2 /home/checker/data/iostat-alerts
gzip /home/checker/data/iostat-logger.log.2

gunzip -d /home/checker/data/iostat-logger.log.3.gz
perl /home/checker/bin/perl_alerter.pl /home/checker/data/iostat-logger.log.3 /home/checker/data/iostat-alerts
gzip /home/checker/data/iostat-logger.log.3

gunzip -d /home/checker/data/iostat-logger.log.4.gz
perl /home/checker/bin/perl_alerter.pl /home/checker/data/iostat-logger.log.4 /home/checker/data/iostat-alerts
gzip /home/checker/data/iostat-logger.log.4

gunzip -d /home/checker/data/iostat-logger.log.5.gz
perl /home/checker/bin/perl_alerter.pl /home/checker/data/iostat-logger.log.5 /home/checker/data/iostat-alerts
gzip /home/checker/data/iostat-logger.log.5
