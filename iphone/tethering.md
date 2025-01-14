# iPhone tethering

## Pre-requisites

1) Ensure the ipheth module is loaded: `sudo modprobe ipheth`

2) install libimobiledevice

## Usage

1) connect the iphone via usb and unlock it

2) enable hotspot on your iphone

3) run `idevicepair pair` and click on `Trust` on your phone

4) a new interface should show up, run `ip link` to check its name

    ```text
    $ ip link
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    ...
    ...
    11: enp0s20fxxxxxxxx <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
        link/ether e6:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
        altname enxxxxxxxxxxxxx
    ```

5) obtain ip address for this interface: `sudo dhcpcd enp0s20fxxxxxxxx`

