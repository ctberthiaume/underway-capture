#!/bin/bash -e

echo "Starting UDP capture in /mnt/underway"

# Listen on container local port 1234, which is host
# port defined in docker-compose.yml. Store entire
# stream in KM_feed.txt and send to kmfeedsplit for
# filtering out subset of data we are interested in
# and timestamping records without. Files saved to
# /mnt/underway.
# 
# All writes are appends, so restarting this script
# or container will not erase existing data.
cd /mnt/underway
/app/udplisten-f04c050 --quiet | tee -a KM_feed.txt | /app/kmfeedsplit
