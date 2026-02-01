# systemd unit example (phoenixd)

Use this as a starting point when you want phoenixd to run as a service.
Adjust paths, user, and environment variables to your setup.

```ini
[Unit]
Description=phoenixd (Phoenix Server Wallet)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=%i
WorkingDirectory=/opt/phoenixd
ExecStart=/opt/phoenixd/phoenixd
Restart=on-failure
RestartSec=3

# Optional: store data somewhere stable
# Environment=PHOENIXD_DATADIR=/var/lib/phoenixd

# Optional: set network explicitly (example)
# Environment=PHOENIXD_CHAIN=testnet

# Hardening (optional)
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true

[Install]
WantedBy=multi-user.target
```
