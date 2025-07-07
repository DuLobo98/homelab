#!/bin/bash

helm repo add uptime-kuma https://dirsigler.github.io/uptime-kuma-helm
helm repo update
helm install uptime-kuma \
    uptime-kuma/uptime-kuma \
    -n uptime-kuma \
    --create-namespace \
    -f values.yaml