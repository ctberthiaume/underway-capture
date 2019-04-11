#!/bin/bash -e
# Should be run from this working directory

port=${1:-1234}
outdir=${2:-.}

if [ ! -d "$outdir" ]
then
    mkdir "$outdir"
fi

echo "Starting UDP capture on port $port appending to directory $outdir" >&2

# All writes are appends, so restarting this script
# or container will not erase existing data.
# Switch to ./udplisten.linux-amd64.f04c050 for linux
./udplisten.darwin.f04c050 -q -p "$port" -b 2048 | \
    tee -a "$outdir"/KM_feed.txt | \
    ./nulleraser | \  # remove null bytes if present
    ./kmfeedsplit "$outdir"
