# Observability

## Metrics platform

The Prometheus stack provides Prometheus, Alertmanager, Grafana, kube-state-metrics, and node exporter. Prometheus retains metrics for 15 days or 20 GiB, whichever limit is reached first. Its scrape interval is 30 seconds. The cluster intentionally does not scrape control-plane manager, scheduler, etcd, or kube-proxy metrics because Talos binds or replaces those components in ways that are not discoverable by this deployment.

Prometheus also scrapes node exporter at the declared Proxmox targets `192.168.1.201:9100`, `192.168.1.202:9100`, and `192.168.1.203:9100`.

Alert delivery and response procedures are documented in [Alerting](../operations/alerting.md).

## Dashboards and interfaces

Grafana has persistent storage and loads generated dashboards from ConfigMaps. Use the documented dashboard tasks rather than manually editing generated JSON:

```bash
task monitoring:dashboards:add:<application>:<grafana-dashboard-id>
task monitoring:dashboards:update
```
