#!/bin/bash

iostat 15 2  -x vda | awk '//{print strftime("%Y-%m-%d %H:%M:%S"),$0}'  >>  /home/checker/data/iostat-logger.log