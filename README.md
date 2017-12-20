# gateway-failover
Router Default Gateway Failover


## config env

```
echo IP_CHECK=192.168.1.1 >> ~/.bashrc
echo GW1=192.168.1.1 >> ~/.bashrc
echo GW2192.168.1.1 >> ~/.bashrc
echo PING_TIMEOUT=2 >> ~/.bashrc
echo IF1=eth0 >> ~/.bashrc
echo IF2=eth0 >> ~/.bashrc

source ~/.bashrc
```


## cron

```
*/1 * * * * sh /usr/bin/gw-failover.sh  >> /var/log/gateway-failover/gw-failover.log
```
