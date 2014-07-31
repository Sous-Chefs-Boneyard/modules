#!/bin/bash

if [ -r /etc/modules-load.d/header ]
    then cat /etc/modules-load.d/header > /etc/modules
    else  > /etc/modules
fi

if ls /etc/modules-load.d/*.conf > /dev/null 2>&1
    then cat /etc/modules-load.d/*.conf >> /etc/modules
fi

