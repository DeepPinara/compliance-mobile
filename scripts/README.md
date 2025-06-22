# Wireless Debugging Script

This script helps you set up wireless debugging for Android devices without needing a USB cable after the initial setup.

## Prerequisites

1. Android 11 (API level 30) or higher
2. ADB (Android Debug Bridge) installed and available in your PATH
3. Device and computer on the same Wi-Fi network
4. USB cable (for initial setup)

## Installation

1. Make the script executable:
   ```bash
   chmod +x wireless_debug.dart
   ```

## Usage

1. Connect your Android device via USB
2. Enable USB debugging in Developer options
3. Run the script:
   ```bash
   dart scripts/wireless_debug.dart
   ```
4. Follow the on-screen instructions to complete the wireless debugging setup

## How It Works

1. The script checks if ADB is installed
2. Verifies your device is connected via USB
3. Guides you through enabling wireless debugging on your device
4. Pairs your device using the pairing code
5. Establishes a wireless connection

## Troubleshooting

- If you get "command not found" for ADB, make sure Android Platform Tools are installed and in your PATH
- Ensure both devices are on the same Wi-Fi network
- The first setup requires a USB connection
- If connection fails, try disabling and re-enabling wireless debugging on your device

## License

This script is provided as-is under the MIT License.
