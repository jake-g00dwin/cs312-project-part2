#!/bin/bash
# Author: Jake G
# Date: 2024
# Filename: minecraft_service.sh

cd /opt/minecraft/server
su minecraft

java -Xmx1024M -Xms1024M -jar ./server.jar
