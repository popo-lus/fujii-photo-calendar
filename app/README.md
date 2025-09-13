# fujii_photo_calendar

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Phase 3.1 Setup (for contributors)

This project uses FVM and Firebase Emulator for local development.

1) FVM (Flutter 3.32.0)
 - Ensure FVM is installed locally.
 - From `app/` run: `fvm use 3.32.0 --force` then use `fvm flutter <cmd>`.

2) Dependencies
 - Fetch packages: `fvm flutter pub get`

3) Firebase Emulator
 - The app toggles emulator use with a Dart env flag `USE_FIREBASE_EMULATORS`.
 - Default is true in code; to disable, pass `--dart-define=USE_FIREBASE_EMULATORS=false`.
 - When enabled, logs similar to `[LOG] {"event":"emulator_setup",...}` will appear.

4) Code generation
 - Run: `fvm dart run build_runner build --delete-conflicting-outputs`

5) Deep Link quick test
 - Android: `adb shell am start -a android.intent.action.VIEW -d "fujii://invite/DEMO" com.example.fujii_photo_calendar`
 - iOS Simulator: `xcrun simctl openurl booted "fujii://invite/DEMO"`
