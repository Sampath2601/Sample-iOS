# Sample-iOS

A Sample login flow built with **SwiftUI**, **MVVM** with both Unit(XCTest) and UI tests(XCUITest).

---
## Project Structure
```
SampleiOS/
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

Open the project in Xcode (15+ recommended)

Build & run on: iOS Simulator

Xcode
```Navigate to Test file and run the class```

Unit Tests (Terminal)
```xcodebuild test \
  -scheme SampleiOS \
  -destination 'platform=iOS Simulator,name=deviceName'```

UI Tests (Terminal)
```xcodebuild test \
  -scheme SampleiOS \
  -destination 'platform=iOS Simulator,name=deviceName' \
  -only-testing SampleiOS_UITests```
