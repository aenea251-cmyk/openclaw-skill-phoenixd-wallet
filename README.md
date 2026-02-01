# phoenixd-wallet (OpenClaw skill)

This repo contains an OpenClaw skill that teaches an agent how to **set up and operate an ACINQ phoenixd Lightning wallet**.

## One-file setup instructions (raw link)

If you want a single copy-pasteable file, use this raw link:

https://raw.githubusercontent.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/master/phoenixd-wallet/SKILL.md

That file includes:
- Download + extract phoenixd from GitHub releases
- Run the daemon
- Use `phoenix-cli` for `getinfo`, `createinvoice`, `decodeinvoice`, `payinvoice`, `sendtoaddress`
- Local QR generation for invoices
- A safe payout helper that verifies invoice amount before paying

## Install the skill

Download the `.skill` file from the latest release:

https://github.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/releases

Then import it into OpenClaw.

## Quick start (manual install without OpenClaw)

If you just want phoenixd itself (outside of OpenClaw), the core commands are:

```bash
VERSION=0.7.2
TARGET=linux-x64   # or linux-arm64

wget "https://github.com/ACINQ/phoenixd/releases/download/v${VERSION}/phoenixd-${VERSION}-${TARGET}.zip"
unzip -j "phoenixd-${VERSION}-${TARGET}.zip"
chmod +x phoenixd phoenix-cli

./phoenixd
```

And in another terminal:

```bash
./phoenix-cli getinfo
```

## Files in this repo

- `phoenixd-wallet/SKILL.md` — the actual skill instructions (treat this as the canonical docs)
- `phoenixd-wallet/scripts/` — helper scripts (QR generation, safe payment)
- `phoenixd-wallet/references/` — extra references (e.g. systemd example)
- `dist/phoenixd-wallet.skill` — packaged skill artifact (also attached to releases)
