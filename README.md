Docker single service stack to capture Kilo Moana underway
instrument feed.

See `docker-compose.yml` and `app/run.sh` for details.


adjust username in plist file appropriately.


```
[ ! -d ~/Library/LaunchAgents ] && mkdir $HOME/Library/LaunchAgents
cp local.underway-capture.plist $HOME/Library/LaunchAgents/
launchctl load $HOME/Library/LaunchAgents/local.underway-capture.plist
```