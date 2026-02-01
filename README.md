---
name: phoenixd-wallet
version: 0.1.7
description: Set up and operate an ACINQ phoenixd Lightning wallet daemon (download/release install, run, and interact via phoenix-cli). Includes local QR generation and a safe payout helper (verify invoice amount before paying).
homepage: https://github.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet
metadata: {"openclaw":{"category":"payments","vendor":"ACINQ","project":"phoenixd"}}
---

# phoenixd-wallet

OpenClaw skill for installing and operating **ACINQ phoenixd** (Lightning wallet daemon) via **phoenix-cli**.

## Skill Files

| File | URL |
|------|-----|
| **SKILL.md** (canonical instructions) | https://raw.githubusercontent.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/master/phoenixd-wallet/SKILL.md |
| **skill.md** (this file, one-file entrypoint) | https://raw.githubusercontent.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/master/skill.md |
| **skill.json** (metadata) | https://raw.githubusercontent.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/master/skill.json |
| **Releases** (.skill download) | https://github.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/releases |

## Setup / Install

### Option A: Import into OpenClaw

1) Download the `.skill` file from Releases:
https://github.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/releases

2) Import it into OpenClaw (Skills → Import).

### Option B: Install locally by fetching the raw SKILL.md

```bash
mkdir -p ~/.openclaw/skills/phoenixd-wallet
curl -s https://raw.githubusercontent.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/master/phoenixd-wallet/SKILL.md > ~/.openclaw/skills/phoenixd-wallet/SKILL.md
```

### Then

Read and follow:
https://raw.githubusercontent.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/master/phoenixd-wallet/SKILL.md
