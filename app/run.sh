#!/bin/bash -e

echo "Starting UDP capture in /mnt/underway" >&2

# Listen on container local port 1234, which is host
# port defined in docker-compose.yml. Store entire
# stream in KM_feed.txt.
#
# All writes are appends, so restarting this script
# or container will not erase existing data.
#/app/udplisten.py | tee -a KM_feed.txt | /app/kmfeedsplit
/app/udplisten-f04c050 -p 1234 -f /mnt/underway/KM_feed.txt -b 2048
