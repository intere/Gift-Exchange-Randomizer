# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Gift Xchanger is an iOS app (Swift 5, iOS 12.0+) for Secret Santa gift exchange randomization. Users enter participant names, and the app randomly assigns each person a gift recipient with no self-assignments.

## Build & Development

**Must use the workspace** (not the .xcodeproj) due to CocoaPods:
```
open "Gift Exchange.xcworkspace"
```

Install dependencies:
```
bundle install
pod install
```

Run tests via Fastlane:
```
bundle exec fastlane test
```

Fastlane lanes: `test`, `beta` (TestFlight), `release` (App Store), `build_info`.

## Architecture

MVC with a Manager/Singleton pattern for business logic.

### Managers (Singletons)
- **NameManager** — CRUD for participant names, persisted to UserDefaults (key: `"names"`), auto-sorted alphabetically
- **MatchupManager** — Randomization algorithm that assigns each person a unique recipient (no self-matches). Uses recursive random selection with deadlock fallback
- **AnalyticsManager** — Wraps AppCenter Analytics for event tracking

### View Controllers
- **RootViewController** — Container that hides the navigation bar
- **MainTableViewController** — Primary screen: name entry text field, name list, and randomize/reset buttons (section-based table view)
- **RandomizeNamesTableViewController** — Displays randomized buyer→recipient results

### Custom Table View Cells
Cells communicate back to controllers via **NotificationCenter** (notification names: `"NewName"`, `"ResetAction"`, `"RandomizeAction"`).

### Validation
**AlertHelper** enforces: minimum 3 names required, no duplicate names.

## Dependencies

Single third-party dependency: **AppCenter 4.1.0** (Analytics + Crashes), managed via CocoaPods.

## Testing

XCTest unit tests in `Gift ExchangeTests/`:
- **NameManagerTest** — Tests add/delete with UserDefaults persistence
- **MatchupManagerTest** — Runs 100 iterations verifying no self-assignments and bijective mapping

Tests run against iPhone 8 (14.3) simulator via Fastlane `scan`.
