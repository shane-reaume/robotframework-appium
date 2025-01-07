# 📱 Robot Framework Appium Mobile Testing

![Robot Framework](https://robotframework.org/img/RF.svg)

> Automated mobile testing for iOS and Android using Robot Framework with Appium

## 🚀 Prerequisites

1. **Install Xcode (for iOS testing)**
   ```bash
   # Install from Mac App Store or
   xcode-select --install
   ```
   - Launch Xcode and accept license agreement
   - Install iOS Simulator from Xcode → Preferences → Components
   - Install iPhone 16 Pro simulator with iOS 18.2

2. **Install Android Studio (for Android testing)**
   ```bash
   # Install Java Development Kit (JDK)
   brew install --cask zulu  # Install latest Zulu JDK
   ```

   Android Studio Setup:
   - Download from [Android Studio website](https://developer.android.com/studio)
   - Install Android Studio
   - During first launch, complete the Android Studio Setup Wizard
   - After setup, in Android Studio:
     1. Click the "More Actions" button (⚙️) or go to "Settings/Preferences"
     2. Navigate to Languages & Frameworks → Android SDK
     3. In the SDK Tools tab:
        - Check "Android SDK Command-line Tools (latest)"
        - Check "Android SDK Build-Tools"
        - Check "Android SDK Platform-Tools"
     4. Click "Apply" and accept any license agreements
     5. Note down the Android SDK Location shown at the top (this is your ANDROID_HOME)

3. **Set up Environment Variables**
   Add these to your shell configuration file (`~/.zshrc` or `~/.bash_profile`):
   ```bash
   # Java Home
   export JAVA_HOME=$(/usr/libexec/java_home)

   # Android SDK
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/tools/bin
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
   export PATH=$PATH:$ANDROID_HOME/build-tools/$(ls $ANDROID_HOME/build-tools | sort -V | tail -1)
   ```
   Then reload your shell:
   ```bash
   source ~/.zshrc  # or source ~/.bash_profile
   ```

4. **Install Node.js**
   ```bash
   brew install node  # or use your preferred Node.js installation method
   ```

## 🚀 Project Setup

1. **Clone and Setup Project**
   ```bash
   git clone https://github.com/shane-reaume/robotframework-appium.git
   cd robotframework-appium
   ```

2. **Install Dependencies**
   ```bash
   # Install Appium and drivers
   npm run setup
   npm run setup-drivers

   # Install Python dependencies
   npm run postsetup
   ```

3. **Create Android Virtual Device**
   - Open Android Studio
   - Go to Tools → Device Manager
   - Click '+ Create Device'
   - Select Pixel 7 → Next
   - Select API 35 → Next
   - Name it 'Pixel_7_API_35' → Finish

4. **Verify Setup**
   ```bash
   # Check iOS setup
   npm run doctor-ios

   # Check Android setup
   npm run doctor-android
   ```

## 🧪 Running Tests

1. **Start Required Services**

   For iOS Testing:
   ```bash
   # Terminal 1: Start Appium server
   npm run start-appium

   # Terminal 2: Start iOS Simulator
   npm run start-ios-sim

   # Terminal 3: Run iOS tests
   npm run test-ios
   ```

   For Android Testing:
   ```bash
   # Terminal 1: Start Appium server
   npm run start-appium

   # Terminal 2: Start Android Emulator
   npm run start-android-emu

   # Terminal 3: Run Android tests
   npm run test-android
   ```

2. **View Test Results**
   - Test results are generated in the `results` directory:
     - `log.html`: Detailed test logs
     - `report.html`: Test execution summary
     - `output.xml`: Machine-readable results

## 🔍 Troubleshooting

1. **iOS Issues**
   - If Xcode path is incorrect:
     ```bash
     sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
     sudo xcodebuild -license accept
     ```
   - If simulator doesn't start:
     ```bash
     xcrun simctl erase all  # Reset all simulators
     ```

2. **Android Issues**
   - If emulator is slow:
     ```bash
     # GPU acceleration is already enabled in our scripts
     # Make sure virtualization is enabled in your BIOS
     ```
   - If ADB doesn't find device:
     ```bash
     adb kill-server
     adb start-server
     ```

3. **Appium Issues**
   - If port 4723 is in use:
     ```bash
     lsof -i :4723  # Find the process
     kill -9 <PID>  # Kill it
     ```
   - If drivers aren't found:
     ```bash
     npm run setup-drivers  # Reinstall drivers
     ```

## 🧹 Cleanup

To remove generated files and virtual environments:
```bash
npm run clean
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.