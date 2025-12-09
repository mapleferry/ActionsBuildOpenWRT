#!/bin/bash

# Modify default IP for x86_64 platform to 192.168.18.1
# Note: Retained only the most common path for IP modification
sed -i 's/192.168.1.1/192.168.18.1/g' package/base-files/files/bin/config_generate