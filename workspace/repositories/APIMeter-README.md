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
- [Daily usage guide](#daily-usage-guide)
- [How the numbers work](#how-the-numbers-work)
- [DeepSeekSync (optional auto-export)](#deepseeksync-optional-auto-export)
- [Development](#development)
- [Troubleshooting](#troubleshooting)
- [Privacy & security](#privacy--security)
- [License](#license)

## Features

- **Menu bar quick panel** - balance, today's cost, 7-day mini trend, top API keys, one click to the dashboard
- **Floating dashboard** - metric cards (balance / today / period cost / requests / tokens), 7D / 30D / This Month / custom ranges, bar chart with per-day per-key hover tooltip, daily history with day detail, multi-select API key filter
- **Per-key cost breakdown** - derived from the official export's `price x amount` rows and cross-checked against billing totals (imports use replace semantics, so re-imports never double-count)
- **Balance-derived Today** - today's cost comes from balance snapshots (yesterday's baseline minus today, top-ups detected and ignored); official exports stay authoritative for completed days
- **Daily export auto-sync** - optional DeepSeekSync module downloads the official usage export once per day at 00:30 (catch-up on launch/wake) and imports it automatically
- **Extras** - balance alerts with anti-spam, launch at login, dock icon toggle, global shortcut (default Option+Space), pin / mini mode, window state restore, dark/light mode, macOS 26 Liquid Glass buttons

## Requirements

- macOS 15 or later
- The prebuilt DMG is Apple Silicon (arm64). Intel Macs: build from source (see [Development](#development)).

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
(paste the absolute path of the DeepSeekSync directory). The daily sync then
downloads AND imports automatically. The Refresh button only updates the
balance - it never triggers a sync.

Security notes: it never reads your normal browser's cookies, never stores your
DeepSeek username or password, and never calls unpublished APIs.

## Development

```bash
swift build && swift test        # core library + CLI + 64 unit tests
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