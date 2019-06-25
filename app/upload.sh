#!/bin/bash

# Assuming we have already configured minio-client (mc) with a host called
# minio, copy underway data hardcoded to ~/Desktop/KM_underway.
date
./mc.darwin cp -q \
    ~/Desktop/KM_underway/HOT_{GPGGA,GPVTG,flor,met,uthsl}_feed.txt \
    minio/input-data/hot_2019_06_30/

if [[ -e ~/realtime/seaflow-realtime-results/sync/stats.csv ]]; then
    ./mc.darwin cp -q \
        ~/realtime/seaflow-realtime-results/sync/stats.csv \
        minio/input-data/hot_2019_06_30/HOT.seaflow-740.stats.csv
fi
