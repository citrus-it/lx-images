#!/bin/sh

xbps-install -ySu vim

rm -rf /root/.cache
rm -rf /var/cache/xbps/*

