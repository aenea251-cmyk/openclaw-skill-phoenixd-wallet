# phoenixd-wallet (OpenClaw skill)

Skill for operating an ACINQ **phoenixd** Lightning wallet daemon from an OpenClaw agent.

- Upstream phoenixd releases: https://github.com/ACINQ/phoenixd/releases

## Install

```bash
mkdir -p ~/.openclaw/skills/phoenixd-wallet
curl -fsSL https://raw.githubusercontent.com/aenea251-cmyk/openclaw-skill-phoenixd-wallet/main/phoenixd-wallet/SKILL.md > ~/.openclaw/skills/phoenixd-wallet/SKILL.md
```

## What it covers

- Download phoenixd/phoenix-cli release binaries
- Run phoenixd
- Common `phoenix-cli` commands: `getinfo`, `createinvoice`, `decodeinvoice`, `payinvoice`, `sendtoaddress`

## License

MIT (for this skill content). phoenixd itself is licensed upstream by ACINQ.
