# 📱 Robot Framework Appium Mobile Testing

![Robot Framework](https://robotframework.org/img/RF.svg)

> Automated mobile testing for iOS and Android using Robot Framework with Appium

## 🚀 Prerequisites Installation

1. **Install Xcode (for iOS testing)**
   ```bash
   # Install from Mac App Store or
   xcode-select --install
   ```
   - Launch Xcode and accept license agreement
   - Install iOS Simulator from Xcode → Preferences → Components

2. **Install Android Studio (for Android testing)**
   ```bash
   # Install Java Development Kit (JDK)
   brew install --cask zulu  # Install latest Zulu JDK

   # Set JAVA_HOME in ~/.zshrc or ~/.bash_profile
   echo 'export JAVA_HOME=$(/usr/libexec/java_home)' >> ~/.zshrc
   source ~/.zshrc
   ```

   Android Studio Setup:
   - Download from [Android Studio website](https://developer.android.com/studio)
   - Install Android Studio
   - During first launch, complete the Android Studio Setup Wizard
   - After setup, in Android Studio:
     1. Click the "More Actions" button (⚙️) or go to "Settings/Preferences":
        - On Mac: Android Studio → Settings (or press ⌘,)
        - On Windows/Linux: File → Settings
     2. Navigate to Languages & Frameworks → Android SDK
     3. In the SDK Tools tab:
        - Check "Android SDK Command-line Tools (latest)"
        - Check "Android SDK Build-Tools"
        - Check "Android SDK Platform-Tools"
     4. Click "Apply" and accept any license agreements
     5. Note down the Android SDK Location shown at the top (this is your ANDROID_HOME)

3. **Set up Environment Variables**
   ```bash
   # Add these to your ~/.zshrc or ~/.bash_profile
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/tools/bin
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
   export PATH=$PATH:$ANDROID_HOME/build-tools/$(ls $ANDROID_HOME/build-tools | sort -V | tail -1)

   # Reload shell configuration
   source ~/.zshrc  # or source ~/.bash_profile
   ```

4. **Install Additional Android Tools**
   ```bash
   # Install bundletool for Android App Bundle support
   brew install bundletool

   # Install gstreamer for screen streaming (optional)
   brew install gstreamer gst-plugins-base gst-plugins-good
   ```

4. **Install Node.js and Appium**
   ```bash
   # Install Node.js using brew
   brew install node

   # Install Appium and core dependencies
   npm install -g @appium/doctor --location=global
   npm install -g appium

   # Install required iOS dependencies
   brew install carthage
   npm install -g ios-deploy

   # Verify core installation
   appium-doctor --ios  # For iOS setup verification
   appium-doctor --android  # For Android setup verification
   ```

   Optional iOS dependencies (install as needed):
   ```bash
   # For MJPEG-over-HTTP features
   npm install -g mjpeg-consumer

   # For simulator location testing
   brew install lyft/formulae/set-simulator-location

   # For enhanced iOS simulator control
   brew tap wix/brew
   brew install applesimutils

   # For advanced iOS device management
   brew tap facebook/fb
   brew install idb-companion
   pip install fb-idb

   # For image comparison features (optional)
   npm install -g opencv4nodejs
   ```

5. **Xcode Setup**
   ```bash
   # Ensure Xcode command line tools point to Xcode.app
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   
   # Verify Xcode path
   xcode-select -p  # Should show: /Applications/Xcode.app/Contents/Developer
   
   # Accept Xcode license
   sudo xcodebuild -license accept
   
   # Verify iOS simulator
   xcrun simctl list devices
   ```

## 📱 Setting Up Test Applications

1. **iOS Test App Setup**
   ```bash
   # Create apps directory
   mkdir -p apps/ios
   cd apps/ios

   # Clone and build iOS test app
   git clone https://github.com/appium/ios-test-app.git
   cd ios-test-app
   npm install
   npm run build

   # The .app file will be in the build folder
   # Update configs/ios.yaml with the correct path
   ```

2. **Android Test App Setup**
   ```bash
   # Create apps directory
   mkdir -p apps/android
   cd apps/android

   # Download Android API Demos app
   curl -L https://github.com/appium/android-apidemos/raw/master/ApiDemos-debug.apk -o TestApp.apk

   # Update configs/android.yaml with the correct path
   ```

## 🚀 Project Setup

1. **Clone and Setup Project**
   ```bash
   git clone https://github.com/shane-reaume/robotframework-appium.git
   cd robotframework-appium
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

2. **Configure Environment**
   ```bash
   cp .env.template .env
   # Edit .env with your device configurations
   ```

3. **Create Virtual Devices**

   For iOS:
   - Open Xcode
   - Go to Window → Devices and Simulators
   - Click '+' to add new simulator
   - Select iPhone 15 Pro with iOS 17.2

   For Android:
   - Open Android Studio
   - Go to Tools → Device Manager
   - Click '+ Create Device'
   - Select Pixel 7 → Next
   - Select API 34 → Next
   - Name it 'Pixel_7_API_34' → Finish

4. **Start Appium Server**
   ```bash
   # Start in a new terminal
   appium
   ```

5. **Run Tests**
   ```bash
   # Start iOS Simulator
   open -a Simulator

   # Method 1: Using YAML config (not recommended)
   # Note: YAML config method can be unreliable due to path resolution issues
   # and environment variable expansion limitations
   robot -A configs/ios.yaml tests/ios/test_app.robot

   # Method 2: Using direct variable assignment (recommended)
   # This method is more reliable as it uses absolute paths and explicit variables
   robot --variable APPIUM_HOST:localhost \
        --variable APPIUM_PORT:4723 \
        --variable PLATFORM_NAME:iOS \
        --variable PLATFORM_VERSION:17.2 \
        --variable DEVICE_NAME:"iPhone 15 Pro" \
        --variable AUTOMATION_NAME:XCUITest \
        --variable APP:${PWD}/apps/ios/ios-test-app/build/Release-iphonesimulator/TestApp-iphonesimulator.app \
        --variable TIMEOUT:30 \
        --variable RETRY_COUNT:2 \
        --outputdir results \
        tests/ios/test_app.robot

   # Start Android Emulator and run tests
   # Replace 'Pixel_7_API_35' with your AVD name
   $ANDROID_HOME/emulator/emulator -avd Pixel_7_API_35 -gpu host

   # Method 1: Using YAML config (not recommended)
   robot -A configs/android.yaml tests/android/test_app.robot

   # Method 2: Using direct variable assignment (recommended)
   robot --variable APPIUM_HOST:localhost \
        --variable APPIUM_PORT:4723 \
        --variable PLATFORM_NAME:Android \
        --variable PLATFORM_VERSION:15.0 \
        --variable DEVICE_NAME:Pixel_7_API_35 \
        --variable AUTOMATION_NAME:UiAutomator2 \
        --variable APP:${PWD}/apps/android/TestApp.apk \
        --variable APP_PACKAGE:io.appium.android.apis \
        --variable APP_ACTIVITY:io.appium.android.apis.ApiDemos \
        --variable TIMEOUT:60 \
        --variable RETRY_COUNT:2 \
        --variable UIAUTOMATOR2_SERVER_LAUNCH_TIMEOUT:60000 \
        --outputdir results \
        tests/android/test_app.robot
   ```

## 📊 Test Capabilities

- 📱 App Installation
- 🔍 Element Location
- 👆 Touch Actions
- ⌨️ Text Input
- 🔄 App State Management
- 📸 Screenshot Capture

## 📝 Test Results

Results are generated in HTML format:
- `log.html` - Detailed test logs
- `report.html` - Test execution summary
- `output.xml` - Machine-readable results

## 🔒 Troubleshooting

1. **Appium Doctor Issues**
   - If you see Carthage missing: `brew install carthage`
   - If Xcode path is incorrect: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`
   - For opencv4nodejs (optional): `npm install -g opencv4nodejs`
   - For simulator location setting: `npm install -g set-simulator-location`
   
2. **iOS Build Issues**
   ```bash
   # Reset iOS simulator
   xcrun simctl erase all
   
   # Verify iOS deployment tools
   ios-deploy --version
   idb list targets
   ```

3. **Android Test Issues**
   ```bash
   # If tests fail with UiAutomator2 server launch timeout
   # Increase the timeout value in the command:
   --variable UIAUTOMATOR2_SERVER_LAUNCH_TIMEOUT:60000

   # If emulator is slow, use GPU acceleration
   $ANDROID_HOME/emulator/emulator -avd Pixel_7_API_35 -gpu host

   # Verify Android device connection
   adb devices
   ```

4. **Appium Server Issues**
   - Verify server is running: `curl http://localhost:4723/wd/hub/status`
   - Check appium-doctor results: `appium-doctor --ios` or `appium-doctor --android`
   - If port 4723 is already in use:
     ```bash
     # Find and kill the process using port 4723
     lsof -i :4723
     kill -9 <PID>
     
     # Or start Appium on a different port
     appium -p 4724
     ```
   - To see detailed logs, start Appium with:
     ```bash
     appium --log appium.log
     ```

5. **iOS Simulator Issues**
   - Reset simulator: Simulator → Device → Erase All Content and Settings
   - Verify Xcode command line tools: `xcode-select -p`
   - If Xcode path is incorrect after update:
     ```bash
     sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
     sudo xcodebuild -license accept
     ```
   - Install XCUITest driver for Appium:
     ```bash
     appium driver install xcuitest
     ```

6. **Android Emulator Issues**
   ```bash
   # Verify Java installation
   java -version  # Should show Java version
   echo $JAVA_HOME  # Should show Java home path
   
   # If Java is not found, reinstall:
   brew install --cask zulu
   source ~/.zshrc

   # Verify Android SDK tools (from Android Studio SDK location)
   ls $ANDROID_HOME/cmdline-tools/latest/bin  # Should show sdkmanager, avdmanager, etc.
   $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --list
   
   # Check Android tools installation
   adb devices  # Should list available devices
   emulator -list-avds  # Should list available emulators
   
   # Update Android SDK tools
   $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --update
   
   # Install specific Android platform
   $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-34"
   
   # Check bundletool installation
   bundletool version

   # If emulator is slow or crashes
   $ANDROID_HOME/emulator/emulator -avd Pixel_7_API_35 -gpu host

   # Verify emulator is properly set up
   adb devices
   ```

   Common fixes:
   - If Java not found: `brew install --cask zulu`
   - If JAVA_HOME is not set: `echo 'export JAVA_HOME=$(/usr/libexec/java_home)' >> ~/.zshrc`
   - If Android SDK location is wrong: Check it in Android Studio → Settings → Languages & Frameworks → Android SDK
   - If sdkmanager not found: Make sure you've installed "Android SDK Command-line Tools (latest)" in Android Studio
   - If ADB not found: `brew install android-platform-tools`
   - If emulator is slow: Enable hardware acceleration in Android Studio AVD Manager

7. **Environment Variable Issues**
   ```bash
   # Add these to your shell's rc file (~/.zshrc or ~/.bash_profile)
   export JAVA_HOME=$(/usr/libexec/java_home)
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/emulator
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/tools/bin
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   
   # After adding variables, always remember to
   source ~/.zshrc  # or source ~/.bash_profile
   ```

## 🔒 Security Notes

- Never commit `.env` files or any credentials
- Use environment variables for sensitive data
- Keep test app credentials secure

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.