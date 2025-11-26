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
