FILE=`pwd`/build/v4l2loopback/v4l2loopback.ko
if test -f "$FILE"; then

echo "Creating a service on /etc/systemd/system/ ..."

echo "
[Unit]
Description=Loads v4l2loopback
DefaultDependencies=false
After=systemd-user-sessions.service
[Service]
Type=simple
WorkingDirectory=`pwd`
ExecStart=sh `pwd`/load-v4l2loopback.sh
[Install]
Alias=v4l2loopback-silverblue.service
WantedBy=multi-user.target" > /etc/systemd/system/v4l2loopback-silverblue.service

chmod +x /etc/systemd/system/v4l2loopback-silverblue.service

echo "Enable service..."
systemctl enable v4l2loopback-silverblue

echo "Starting service"
systemctl restart v4l2loopback-silverblue

echo "OK.Bye bye"
else
    echo "$FILE does not exist. You must execute podman_build.sh first"
fi
