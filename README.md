**English** 

# Aria2 Docker

A perfect Aria2 Docker image. Out of the box, just add download tasks and don't need to think about anything else.

## Features

* Supported platforms: `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6`
* Full Function: `Async DNS`, `BitTorrent`, `Firefox3 Cookie`, `GZip`, `HTTPS`, `Message Digest`, `Metalink`, `XML-RPC`, `SFTP`
* `max-connection-per-server` unlimited.
* retry on slow speed (`lowest-speed-limit`) and connection close
* High BT download rate and speed
* Get BitTorrent tracker automatically
* Download error automatically delete files
* Download cancel automatically delete files
* Automatically clear `.aria2` suffix files
* Automatically clear `.torrent` suffix files
* No lost task progress, no repeated downloads
* And more powerful features

## Usage

### Docker CLI

- No matter what architecture platform is used, just use the following command to start the container ( Just need to replace the `<TOKEN>` field ):
```
docker run -d \
    --name aria2 \
    --restart unless-stopped \
    --log-opt max-size=1m \
    -e PUID=$UID \
    -e PGID=$GID \
    -e UMASK_SET=022 \
    -e RPC_SECRET=<TOKEN> \
    -e RPC_PORT=6800 \
    -p 6800:6800 \
    -e LISTEN_PORT=6888 \
    -p 6888:6888 \
    -p 6888:6888/udp \
    -v $PWD/aria2-config:/config \
    -v $PWD/aria2-downloads:/downloads \
    kerollos29/aria2-armv6
```

- Then you need a WebUI for control, such as [AriaNg](https://github.com/mayswind/AriaNg). [This link](http://ariang.mayswind.net/latest) is provided by the developer and can be used directly. Or use Docker to deploy it yourself:
```
docker run -d \
    --name ariang \
    --log-opt max-size=1m \
    --restart unless-stopped \
    -p 6880:6880 \
    kerollos29/aria2-armv6
```

> **TIPS:** It is important for the firewall to open ports.

### Docker Compose

- Compose up
```
docker-compose -f aria2.yml up -d
```

## Parameters

| Parameter                        | Function                                                                                                                                                                  |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-e PUID=$UID`<br>`-e PGID=$GID` | Bind UID and GID to the container, which means you can use a non-root user to manage downloaded files.                                                                    |
| `-e UMASK_SET=022`               | For umask setting of Aria2, optional , default if left unset is `022`                                                                                                     |
| `-e RPC_SECRET=<TOKEN>`          | Set RPC secret authorization token. Default: `P3TERX`                                                                                                                     |
| `-e RPC_PORT=6800`               | Set RPC listen port.                                                                                                                                                      |
| `-p 6800:6800`                   | bind RPC listen port.                                                                                                                                                     |
| `-e LISTEN_PORT=6888`            | Set TCP/UDP port number for BitTorrent/DHT listen.                                                                                                                        |
| `-p 6888:6888`                   | Bind BT listen port (TCP).                                                                                                                                                |
| `-p 6888:6888/udp`               | Bind DHT lisen port (UDP).                                                                                                                                                |
| `-v <PATH>:/config`              | Contains all relevant configuration files.                                                                                                                                |
| `-v <PATH>:/downloads`           | Location of downloads on disk.                                                                                                                                            |
| `-e DISK_CACHE=<SIZE>`           | Set up disk cache. SIZE can include `K` or `M` (1K = 1024, 1M = 1024K), e.g `64M`.                                                                                        |
| `-e IPV6_MODE=<BOOLEAN>`         | Whether to enable IPv6 support for Aria2. Optional: `true` or `false`. Set the options `disable-ipv6=false` and `enable-dht6=true` in the configuration file(aria2.conf). |
| `-e UPDATE_TRACKERS=<BOOLEAN>`   | Whether to update BT Trackers List automatically. Optional: `true` or `flase`, default if left unset is `true`                                                            |
| `-e CUSTOM_TRACKER_URL=<URL>`    | Custom BT Trackers List URL. If not set, it will be get from https://trackerslist.com/all_aria2.txt.                                                                      |
| `-e TZ=Asia/Shanghai`            | Specify a timezone to use e.g. `Asia/Shanghai`                                                                                                                            |

