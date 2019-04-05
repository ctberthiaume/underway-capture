#!/bin/bash

# Assuming we have already configured minio-client (mc) with a host called
# minio, copy underway data hardcoded to ~/Desktop/KM_underway.
date
./mc.darwin cp -q \
    ~/Desktop/KM_underway/KM_{GPGGA,GPVTG,flor,met,uthsl}_feed.txt \
    minio/input-data/gradients3/
