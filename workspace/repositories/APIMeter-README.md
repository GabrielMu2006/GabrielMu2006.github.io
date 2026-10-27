# API Meter

> Native macOS menu bar + floating dashboard for DeepSeek API usage.

[English](README.md) | [简体中文](README.zh-CN.md)

![platform](https://img.shields.io/badge/platform-macOS%2015%2B-blue) ![swift](https://img.shields.io/badge/Swift-6-orange) ![license](https://img.shields.io/badge/license-MIT-green) [![CI](https://github.com/GabrielMu2006/APIMeter/actions/workflows/ci.yml/badge.svg)](https://github.com/GabrielMu2006/APIMeter/actions/workflows/ci.yml)

API Meter is a local-first macOS app that turns the official DeepSeek data
(balance API + usage exports) into a native, always-on desktop dashboard.
All data stays on your Mac. No scraping, no cookies, no MITM.

## Table of contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [First-run configuration](#first-run-configuration)
- [Coding Plan quotas (ZCode / Kimi / Qoder / Codex)](#coding-plan-quotas-zcode--kimi--qoder--codex)
- [Daily usage guide](#daily-usage-guide)
- [How the numbers work](#how-the-numbers-work)
- [DeepSeekSync (optional auto-export)](#deepseeksync-optional-auto-export)
- [Development](#development)
- [Troubleshooting](#troubleshooting)
- [Privacy & security](#privacy--security)
- [License](#license)

## Features

- **Menu bar quick panel** - DeepSeek balance + today in one row, coding-plan rings (ZCode / Kimi / Qoder) with reset times, one click to the dashboard
- **Floating dashboard** - equal quarters for DeepSeek / ZCode / Kimi / Qoder, period stats beside the filters, bar chart with per-day per-key hover tooltip, daily history with day detail, multi-select API key filter
- **macOS system widgets (WidgetKit)** - optional native widgets for the desktop / Notification Center: Coding Plan rings (medium) and DeepSeek balance (small), fed by the app's refresh cycle
- **Desktop widgets** - desktop-level widget rows, one per provider (ZCode 5h+weekly, Kimi 5h+weekly, Qoder monthly credits + org pool, DeepSeek balance + today); drag to move, click opens the dashboard, right-click for actions (toggle Option+W)
- **ZCode (GLM Coding Plan) quota** - 5-hour and weekly windows with reset times, via the same quota-monitor endpoint the official glm-plan-usage plugin uses; the Coding Plan key lives in its own Keychain service, quota refresh is throttled to once per 5 minutes
- **Kimi (Kimi Code) quota** - weekly and 5-hour windows auto-detected from the Kimi CLI credential (~/.kimi-code); expired tokens refresh themselves with the stored refresh token (rotated tokens written back, lineage-checked), so no manual CLI runs
- **Qoder (CN) quota** - monthly credit pool (and the team org resource package when provisioned), auto-detected from the Qoder desktop app's encrypted auth file (Keychain SafeStorage -> AES decrypt, read-only); the token lives about a month
- **Codex (ChatGPT plan) quota** - 5-hour and weekly rate-limit windows auto-detected from the Codex CLI credential (~/.codex/auth.json); the ~10-day token auto-refreshes (rotating, lineage-checked write-back). Optional proxy setting (off by default) for networks where chatgpt.com is unreachable; when the endpoint can't be reached, API Meter falls back to the rate limits the CLI writes into its session log
- **Per-key cost breakdown** - derived from the official export's `price x amount` rows and cross-checked against billing totals (imports use replace semantics, so re-imports never double-count)
- **Balance-derived Today** - today's cost comes from balance snapshots (yesterday's baseline minus today, top-ups detected and ignored); official exports stay authoritative for completed days
- **Daily export auto-sync** - optional DeepSeekSync module downloads the official usage export once per day at 00:30 (catch-up on launch/wake) and imports it automatically
- **Extras** - balance alerts with anti-spam, launch at login, dock icon toggle, global shortcuts (Option+Space dashboard, Option+W widgets), window state restore, dark/light mode, macOS 26 Liquid Glass buttons

## Requirements

- macOS 15 or later
- The prebuilt DMG is Apple Silicon (arm64). Intel Macs: build from source (see [Development](#development)).
- Building from source requires Xcode 26+ (macOS 26 SDK, for the Liquid Glass button styles); the app itself runs on macOS 15+.

## Installation

### Option A - download the DMG (recommended)

1. Go to [Releases](../../releases) and download `API-Meter-x.y.z.dmg`.
2. Open the DMG and drag **API Meter** into **Applications**.
3. First launch: **right-click the app -> Open** (the build is ad-hoc signed;
   see Troubleshooting).
4. The app lives in the menu bar - no Dock icon by default.

### Option B - build from source

```bash
git clone https://github.com/GabrielMu2006/APIMeter.git
cd APIMeter
xcodebuild -project APIMeter.xcodeproj -scheme APIMeter \
  -configuration Release -derivedDataPath .build/DerivedData-Release build
open ".build/DerivedData-Release/Build/Products/Release/API Meter.app"
```

Or open `APIMeter.xcodeproj` in Xcode and press Run.

## First-run configuration

### 1. Add your DeepSeek API key

1. Click the menu bar icon -> gear icon (or open the dashboard and click the gear).
2. Go to **DeepSeek** and paste your API key into the secure field.
3. Click **Save to Keychain**, then **Test Connection**. Your balance should appear.

The key is stored ONLY in the macOS Keychain (item `com.apimeter.deepseek-api-keys`).
The database stores a SHA256 fingerprint of the key - never the key itself.

### 2. Import your usage history

1. Export your usage on DeepSeek's platform:
   `platform.deepseek.com -> Usage (用量信息) -> pick a time range -> Export (导出)`.
   You get a ZIP containing `amount-*.csv` (tokens/requests per key) and
   `cost-*.csv` (money per day/model).
2. In API Meter: **Settings -> Data -> Import Usage Export...** (or drag the
   ZIP/CSV anywhere onto the Data page).
3. Re-importing is safe: files are deduplicated by SHA256, and updated
   exports REPLACE earlier totals for the same day buckets.

### 3. (Optional) Enable the daily auto-export

See [DeepSeekSync](#deepseeksync-optional-auto-export). Without it you simply
re-import exports by hand whenever you want fresh history.

### 4. Balance alerts

**Settings -> Notifications**: pick a threshold (Off / 5 / 10 / 20 / custom)
and click **Allow Notifications**. You are notified once per drop below the
threshold; the alert re-arms after the balance rises above it again.
If the system prompt was dismissed: System Settings -> Notifications -> API Meter.

### 5. General

- **Launch at Login**: the app must be in /Applications for reliable login items.
- **Show Dock Icon**: toggles the Dock presence immediately.
- **Global Shortcut**: default Option+Space; record your own combination.
- **Appearance**: System / Light / Dark.

## Coding Plan quotas (ZCode / Kimi / Qoder / Codex)

All providers feed the menu bar panel, the dashboard and the desktop
widgets. Snapshots are kept locally for 30 days; automatic refresh is
throttled to one request per 5 minutes per provider.

### ZCode (GLM Coding Plan) - paste an API key

1. Create an API key in your provider console (BigModel China or Z.ai
   global, Coding Plan section).
2. Settings -> Coding Plans -> paste the key -> **Save to Keychain**.
3. Pick the region (BigModel China = open.bigmodel.cn, Z.ai global =
   api.z.ai) and click **Test Connection**. Your 5-hour and weekly windows
   (remaining % + reset time) now appear everywhere.

### Kimi (Kimi Code) - automatic

- Install and log in to the Kimi CLI once (`kimi login`). API Meter reads
  `~/.kimi-code/credentials/kimi-code.json` read-only.
- The access token lives ~15 minutes; API Meter refreshes it by itself
  with the stored refresh token and writes the rotated tokens back, so the
  CLI keeps working. Only if the refresh token itself dies do you need
  `kimi login` again.

### Qoder (CN) - automatic

- Install and log in to the Qoder CN desktop app. API Meter decrypts its
  auth file read-only; macOS asks once for keychain access - choose
  **Always Allow**.
- The token lives about a month (expiry shown in Settings -> Coding
  Plans). Your monthly credit pool appears immediately; the team org
  resource pool shows up automatically once your org provisions one.

### Codex (ChatGPT plan) - automatic

- Install and run `codex login` once. API Meter reads `~/.codex/auth.json`
  read-only; the ~10-day access token refreshes itself with the stored
  refresh token (rotating, lineage-checked write-back), so the CLI keeps
  working. Only a dead refresh token needs `codex login` again.
- The usage endpoint is chatgpt.com, which is unreachable on some networks
  (URLSession ignores environment-variable proxies). If your Codex CLI
  works through a local proxy, enable **Settings -> Coding Plans -> Codex ->
  Use proxy for Codex requests** and enter the same address, e.g.
  `http://127.0.0.1:8080` or `socks5://127.0.0.1:7890`. The setting is off
  by default and only affects API Meter's own quota request.
- When the endpoint is unreachable anyway, API Meter falls back to the
  rate limits the Codex CLI records in its session log, so the card still
  shows your last known windows (as of your latest Codex use).

### Desktop widgets (default shortcut Option+W)

- Enable in Settings -> General (or Settings -> Coding Plans -> Desktop
  Widgets). One row per provider appears at desktop level: ZCode 5h +
  weekly, Kimi 5h + weekly, Qoder monthly + org pool, DeepSeek balance +
  today.
- Drag to move (position remembered), click a card to open the dashboard,
  right-click for actions: open dashboard / click-through (pure display)
  mode / refresh / hide.

### macOS system widgets (WidgetKit, optional)

- The app also ships two native macOS widgets you can place on the desktop
  or in Notification Center (long-press the desktop / open Notification
  Center -> Edit Widgets -> search "API Meter"):
  - **Coding Plan 额度** (medium / large): ring cells for ZCode / Kimi /
    Qoder / Codex with remaining % and live 5-hour reset countdowns; the
    large size adds a DeepSeek balance + today header, per-window remaining
    amounts and reset dates - the whole panel in one widget.
  - **DeepSeek 余额** (small): current balance and today's spend.
- Data comes from the app itself: every successful refresh writes a
  snapshot and reloads the widget timelines, so the widgets stay as fresh
  as the app (the extension is sandboxed, reads only that snapshot file,
  and never touches your keys or the network).
- These coexist with the custom desktop widget panel above; use whichever
  fits. Clicking a system widget opens API Meter.

## Daily usage guide

| Where | What you get |
|---|---|
| Menu bar panel | Balance + last update, Today (requests/tokens), 7-day mini trend, top 3 keys, Open Dashboard / Settings / Quit |
| Dashboard header | Pin (floating level), Mini mode, Settings, Refresh (balance only - never triggers export sync) |
| Metric cards | Balance, Today (click it to open today's detail), Period Cost, Requests, Tokens |
| Chart | Hover any bar: date, cost, requests, tokens and the day's per-key costs |
| Daily Usage list | Click a day for its detail: totals + per-key breakdown |
| API Keys panel | Per-key cost / requests / tokens for the selected period; multi-select filter above |
| Mini mode | Balance + today only; drag to move, double-click to expand, right-click for actions |

## How the numbers work

- **Official export is authoritative for completed days.** Its day buckets are
  cumulative snapshots, so imports use replace semantics per (day, model, api key).
- **Per-key cost** is derived from the export's own `price x amount` rows and
  cross-checked against the billing totals at import; on mismatch the rows are
  marked estimated instead of official.
- **Money is Decimal, tokens are Int64, timestamps UTC.** Day buckets are
  computed once at import in the local timezone; changing timezones cannot
  corrupt history.

### How Today's cost is calculated (balance-delta method)

Today's cost is an ESTIMATE computed from balance snapshots - the balance API
has no per-key or per-period data, so this is the only live signal available:

1. **Baseline**: the last balance snapshot BEFORE local midnight (captured
   automatically - the app stores a snapshot on every balance refresh).
2. Every snapshot taken today is compared with the previous one:
   - balance went DOWN -> the difference counts as spending
   - balance went UP -> treated as a top-up (or grant) and ignored
3. The sum of all decreases = Today's cost. It updates on every balance
   refresh: every 60 s while a panel/dashboard is visible, every 15 min in
   the background.

Fallbacks (shown with an explicit label on the Today card):

- **No midnight baseline yet** (e.g. first day after install, or the Mac was
  off over midnight): the estimate starts from the FIRST snapshot of today
  and is labeled "since HH:mm". It under-counts whatever was spent before
  that first snapshot.
- **A baseline older than 24 h is rejected** (it would mix multiple days).
- **No snapshots at all**: the card falls back to the latest official export
  value, stamped with its import time.

### Important: do not top up while actively using the API

Top-ups HIDE spending in this method: the balance jumps up, and any spending
that happens inside the same snapshot window (before the next refresh) is
absorbed by the jump - the drop never appears, so the day's estimate
under-counts. **Top up when the API is idle instead.** Whatever the estimate
says, the official export (auto-synced daily at 00:30) corrects the record
for completed days.

## DeepSeekSync (optional auto-export)

A standalone CLI (Node + Playwright) that opens the official usage page in its
OWN browser profile, clicks the official Export button and downloads the ZIP.
The app runs it once per day at 00:30 (or at the next launch/wake if missed).

**One-click setup (v1.3.0):** if no path is configured, API Meter asks at launch
whether to download and install the module for you (source-only archive from
GitHub, then setup-runtime.sh downloads portable Node + Chromium, ~450MB once,
then the DeepSeek login window opens automatically). The managed copy lives in
~/Library/Application Support/APIMeter/DeepSeekSync. Manual steps (also fine):

```bash
cd DeepSeekSync
./scripts/setup-runtime.sh   # bundles portable Node + installs Playwright + Chromium (no system install)
./deepseek-sync login       # a browser window opens - sign in by hand (any captcha/MFA)
                            # the session (cookies + localStorage) is saved to the macOS Keychain
./deepseek-sync sync        # headless-free hidden run: picks 近30天, clicks 导出, downloads the ZIP
./deepseek-sync status      # session + last sync info
./deepseek-sync dump        # debug: print the page's buttons/links
./deepseek-sync logout      # remove the saved session
```

Then tell the app where the folder lives: **Settings -> Data -> DeepSeekSync path**
(paste the absolute path of the DeepSeekSync directory), or use **DeepSeekSync
Setup -> 自动下载并安装** in the same screen. The daily sync then downloads AND
imports automatically. The Refresh button only updates the balance - it never
triggers a sync.

Security notes: it never reads your normal browser's cookies, never stores your
DeepSeek username or password, and never calls unpublished APIs.

## Development

```bash
swift build && swift test        # core library + CLI + 80 unit tests
.build/debug/apimeter selfcheck  # end-to-end self checks (keychain/db/csv/pricing)
.build/debug/apimeter help
```

CLI commands: `keychain set/list/delete`, `balance`, `db init/info/dump`,
`analyze`, `import`, `daily`, `rebuild`, `selfcheck`.

Layout:

```
APIMeter/            app + core sources (Xcode app target + SPM library)
Tools/PhaseAValidator validation CLI
DeepSeekSync/        Playwright export downloader (standalone, bundled Node gitignored)
Tests/               Swift Testing unit tests
docs/                schema + phase reports (real samples gitignored)
```

Pull requests are welcome - see CONTRIBUTING.md. CI runs build + tests on
macOS runners.

## Troubleshooting

| Problem | Fix |
|---|---|
| "API Meter" can't be opened (unverified developer) | Right-click -> Open on first launch (ad-hoc signature) |
| Balance fails after a rebuild | The Keychain entry is tied to the build - re-enter the key in Settings -> DeepSeek |
| Today shows "—" | No pre-midnight balance snapshot yet; keep the app running, or it falls back to the official value |
| Daily sync: "session expired" | Run `./deepseek-sync login` again in DeepSeekSync |
| Daily sync: "not configured" | Set the DeepSeekSync folder path in Settings -> Data |
| Numbers seem too high | Old bug: re-imports could accumulate (fixed in replace semantics). Re-import the latest export or `apimeter rebuild <zip>` |
| Notifications not arriving | System Settings -> Notifications -> API Meter -> Allow |

## Privacy & security

- API keys live only in the macOS Keychain; SQLite stores SHA256 fingerprints.
- No browser cookies, no Usage-page scraping beyond the official export button,
  no HTTPS MITM, no root certificates.
- Logs are redacted (`sk-***`) and never contain prompts or completions.
- All data stays on your Mac. See [PRIVACY.md](PRIVACY.md).

## License

[MIT](LICENSE)