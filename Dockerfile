#     _         _       ____
#    / \   _ __(_) __ _|___ \  
#   / _ \ | '__| |/ _` | __) | 
#  / ___ \| |  | | (_| |/ __/  
# /_/   \_\_|  |_|\__,_|_____|
#

FROM p3terx/s6-alpine

RUN apk add --no-cache jq findutils git
RUN apk add aria2
RUN rm -rf /var/cache/apk/* /tmp/*

COPY rootfs /

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=0 \
    RCLONE_CONFIG=/config/rclone.conf \
    UPDATE_TRACKERS=true \
    CUSTOM_TRACKER_URL= \
    LISTEN_PORT=6888 \
    RPC_PORT=6800 \
    RPC_SECRET= \
    PUID= PGID= \
    DISK_CACHE= \
    IPV6_MODE= \
    UMASK_SET= \
    SPECIAL_MODE=

EXPOSE \
    6800 \
    6888 \
    6888/udp

VOLUME \
    /config \
    /downloads