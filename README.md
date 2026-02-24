# Sample-iOS

A Sample login flow built with **SwiftUI**, **MVVM** with both Unit(XCTest) and UI tests(XCUITest).

---
## Project Structure
```
SampleiOS/
├── Sample.xcodeproj                → Project file    
├── Sample/
│   └── SampleiOSApp.swift        	→ App entry point
│   └── ContentView.swift         	→ UI layer (SwiftUI)
│   |── Login/
│   |   ├── LoginView.swift       	→ UI layer (SwiftUI)
│   │	├── LoginViewModel.swift  	→ MVVM ViewModel logic
│   │   └── LoginState.swift
│   │
│   └── Mocks/
│       ├── MockNetworkMonitor.swift  	→ Mock or provider for tests
│       ├── MockAuthService.swift
│	└── etc
├── Tests/                            	→ Unit Tests target
│   ├── LoginViewModelTests.swift
│
└── UITests/                          	→ UI Test target
    ├── Screens/
    ├── Tests/
    ├── Utils/

```
---
---
## UI Test Architecture

- Implemented automated UI test framework using **XCUITest**.
- Scalable test framework using **Page Object Model (POM)** pattern.
- Structured test layers into:
  - `Base Test` → centralized app launch & setup
  - `Screen classes` → encapsulated UI interactions & assertions
  - `Test classes` → scenario-based validation
- Used stable accessibility identifiers for reliable UI element selection.
- Added utility helpers to simulate controlled test states.
- Ensured clean separation of readability, and maintainability.
---

## ScreenRecording
This app uses Credentials **Username**: test, **Password**: password


https://github.com/user-attachments/assets/dfabd43f-d1bf-43e7-adb0-b891d707f794


---
# Running the Project

Open the project in Xcode(.xcodeproj) (16+ recommended)

Build & Run on: iOS Simulator

# Xcode
```
App -> Open the project in Xcode(.xcodeproj extension file) (16+ recommended)

Tests -> Navigate to Test file and Run the class
```

# Unit Tests (Terminal)
```
xcodebuild test \
  -scheme SampleiOS \
  -destination 'platform=iOS Simulator,name=deviceName'
```

# UI Tests (Terminal)
```
xcodebuild test \
  -scheme SampleiOS \
  -destination 'platform=iOS Simulator,name=deviceName' \
  -only-testing SampleiOS_UITests
```
