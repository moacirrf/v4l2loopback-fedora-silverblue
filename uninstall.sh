echo "Removing service..."
systemctl disable v4l2loopback-silverblue
rm /etc/systemd/system/v4l2loopback-silverblue.service
rm /etc/systemd/system/v4l2loopback-silverblue-failure.service

echo "Unloading module v4l2loopback"
rmmod `pwd`/build/v4l2loopback/v4l2loopback.ko
echo "Ok.Bye bye"
