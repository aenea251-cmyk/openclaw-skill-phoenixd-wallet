---
name: phoenixd-wallet
description: Set up and operate an ACINQ phoenixd Lightning wallet daemon (download/release install, run, and interact via phoenix-cli). Use when you need quick commands to install phoenixd, start the daemon, and do common wallet actions like getinfo, createinvoice, pay invoices, and send on-chain (sendtoaddress).
---

# phoenixd wallet (phoenixd)

## Quick start (release binary)

1) Pick a release version and target architecture from <https://github.com/ACINQ/phoenixd/releases>

2) Download + extract the binaries (example uses `v0.7.2` + `linux-x64`):

```bash
VERSION=0.7.2
TARGET=linux-x64

wget "https://github.com/ACINQ/phoenixd/releases/download/v${VERSION}/phoenixd-${VERSION}-${TARGET}.zip"
unzip -j "phoenixd-${VERSION}-${TARGET}.zip"
chmod +x phoenixd phoenix-cli
```

(Or run the bundled helper: `./scripts/download_phoenixd.sh 0.7.2 linux-x64`)

3) Run the daemon:

```bash
./phoenixd
```

Keep it running (separate terminal / tmux / systemd).

## Common phoenix-cli commands

### Basic info

```bash
./phoenix-cli getinfo
```

### Create a Lightning invoice

```bash
./phoenix-cli createinvoice \
  --description "my first invoice" \
  --amountSat 12345
```

### Send funds to an on-chain bitcoin address

```bash
./phoenix-cli sendtoaddress \
  --address tb1q2qlmx0t2g33tjgujr8h53dxmypuf8qps9jnv8q \
  --amountSat 100000 \
  --feerateSatByte 12
```

## Operational notes

- Run as a dedicated unprivileged user; avoid running as root.
- For long-running setups, install it under a stable path (e.g. `/opt/phoenixd`) and manage it with a supervisor.
- For a systemd unit example, read `references/systemd.md`.

## Troubleshooting checklist

- `unzip: command not found` → install `unzip`.
- `cannot execute binary file` → wrong target (e.g. `linux-x64` vs `linux-arm64`).
- CLI cannot reach daemon → ensure the daemon is running and you’re using the same working directory/config.
