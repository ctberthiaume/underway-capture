### Get minio client for darwin and linux
```
curl -o app/mc.darwin https://dl.minio.io/client/mc/release/darwin-amd64/mc
chmod +x app/mc.darwin
curl -o app/mc.linux-amd64 https://dl.minio.io/server/minio/release/linux-amd64/minio
chmod +x app/mc.linux-amd64
```

### Install underway capture service
```
[ ! -d ~/Library/LaunchAgents ] && mkdir ~/Library/LaunchAgents
[ ! -d ~/log ] && mkdir ~/log
cp local.underway-capture.plist $HOME/Library/LaunchAgents/
# Adjust username or paths in service before loading
launchctl load $HOME/Library/LaunchAgents/local.underway-capture.plist
```

### Install underway upload service
```
[ ! -d ~/Library/LaunchAgents ] && mkdir ~/Library/LaunchAgents
[ ! -d ~/log ] && mkdir ~/log
cp local.underway-upload.plist ~/Library/LaunchAgents/
# Adjust username or paths in service before loading
launchctl load $HOME/Library/LaunchAgents/local.upload-capture.plist
```
