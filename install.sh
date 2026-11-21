FILE=`pwd`/build/v4l2loopback/v4l2loopback.ko
if test -f "$FILE"; then

echo "Creating a service on /etc/systemd/system/ ..."

echo "
[Unit]
Description=Loads v4l2loopback
DefaultDependencies=false
After=systemd-user-sessions.service
OnFailure=v4l2loopback-silverblue-failure.service
[Service]
Type=simple
WorkingDirectory=`pwd`
ExecStart=sh `pwd`/load-v4l2loopback.sh
Restart=on-failure
RestartSec=60
[Install]
Alias=v4l2loopback-silverblue.service
WantedBy=multi-user.target" > /etc/systemd/system/v4l2loopback-silverblue.service


echo "Creating service on /etc/systemd/system/v4l2loopback-silverblue-failure.service ..."

echo "
[Unit]
Description=Builds v4l2loopback
DefaultDependencies=false
After=systemd-user-sessions.service
[Service]
User=`logname`
Type=simple
WorkingDirectory=`pwd`
ExecStart=sh `pwd`/podman_build.sh --scope user
[Install]
Alias=v4l2loopback-silverblue-failure.service
WantedBy=multi-user.target" > /etc/systemd/system/v4l2loopback-silverblue-failure.service

chmod +x /etc/systemd/system/v4l2loopback-silverblue.service
chmod +x /etc/systemd/system/v4l2loopback-silverblue-failure.service

echo "Enable service..."
systemctl enable v4l2loopback-silverblue

echo "Starting service"
systemctl restart v4l2loopback-silverblue

echo "OK.Bye bye"
else
    echo "$FILE does not exist. You must execute podman_build.sh first"
fi
