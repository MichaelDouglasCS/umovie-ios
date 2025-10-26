# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

uMovie is a social iOS app that connects users to an extensive catalog of Movies and TV Shows powered by TMDb. The project uses UIKit with a VIPER architecture pattern and programmatic UI (no Storyboards).

## Essential Commands

### Opening the Project
```bash
# IMPORTANT: Always use the .xcworkspace file, NOT .xcodeproj
cd Core
open uMovie.xcworkspace
```

### Managing Dependencies
```bash
cd Core
pod install              # Install/update CocoaPods dependencies
pod install --repo-update  # Update pod repositories and install
```

### Code Generation
```bash
cd Core
swiftgen config run --config swiftgen.yml  # Regenerate Assets and Localization enums
```

### Linting
```bash
cd Core
swiftlint                # Run SwiftLint on the project
swiftlint --fix         # Auto-fix violations where possible
```

### Building and Testing
```bash
cd Core
xcodebuild -workspace uMovie.xcworkspace -scheme uMovie -configuration Debug build
xcodebuild -workspace uMovie.xcworkspace -scheme uMovie -configuration Debug test
```

## Architecture

### VIPER Pattern

The project follows a VIPER (View-Interactor-Presenter-Entity-Router) architecture with customizations:

**Standard VIPER Components per Scene:**
- **View** (`*View.swift`): UIView subclass containing UI elements
- **ViewController** (`*ViewController.swift`): Container managing view lifecycle and delegating interactions
- **Interactor** (`*Interactor.swift`): Business logic coordinator, calls workers
- **Presenter** (`*Presenter.swift`): Formats data for display (some WIP)
- **Router** (`*Router.swift`): Navigation and scene transitions
- **Factory** (`*Factory.swift`): Dependency injection assembly
- **Worker** (`*Worker.swift`): Reusable task execution (API calls, network)
- **UseCase** (`*UseCase.swift`): Request/Response/ViewModel models for data flow

**Protocol-Driven Design:**
Every component has an associated protocol. For example:
```swift
protocol LoginEmailAuthBusinessLogic {
    func authenticate(request: LoginEmailAuth.Authenticate.Request)
}

final class LoginEmailAuthInteractor: LoginEmailAuthBusinessLogic {
    // Implementation
}
```

**Simplified VIPER:**
Simple presentation-only scenes (like `LoginOptionsScene`) may omit Interactor/Presenter/Worker and only include View/ViewController/Router/Factory.

### Project Structure

```
Core/uMovie/Sources/
├── Modules/                    # Feature modules (feature-based organization)
│   └── Login/
│       ├── OptionsScene/       # Login method selection screen
│       ├── EmailAuthScene/     # Email/password authentication screen
│       └── CreateAccountScene/ # Account creation screen
└── Shared/                     # Shared resources (layer-based organization)
    ├── Components/             # Reusable UI components
    │   ├── Buttons/           # CustomActionButton
    │   └── TextFields/        # CustomTextField
    ├── Network/               # NetworkProvider (Alamofire wrapper)
    ├── Extensions/            # UIKit extensions
    ├── Generated/             # SwiftGen output (DO NOT EDIT MANUALLY)
    └── Utils/                 # Utility functions
```

### Data Flow

View → ViewController → Interactor → Worker → API
                                    ↓
View ← ViewController ← Presenter ← (response)

## Key Technologies

- **Language:** Swift (UIKit, not SwiftUI)
- **Layout:** SnapKit DSL for programmatic Auto Layout
- **Networking:** Alamofire 5.4 via NetworkProvider singleton
- **Image Loading:** Kingfisher
- **Analytics:** Firebase/Crashlytics, Firebase/Analytics
- **Secure Storage:** KeychainAccess
- **Keyboard:** IQKeyboardManager (auto-configured in AppDelegate)
- **Code Generation:** SwiftGen for type-safe assets and localization
- **Linting:** SwiftLint

## Important Patterns and Conventions

### UI Layout with SnapKit
All UI is programmatic using SnapKit constraints:
```swift
titleLabel.snp.makeConstraints { make in
    make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
    make.leading.equalTo(self).offset(16)
}
```

### Type-Safe Resources via SwiftGen
Always use generated enums instead of string literals:
```swift
// Colors
let color = Colors.brandColor.color

// Images
let image = Images.umovieIcon.image

// Localization
let text = Localization.Login.EmailAuthentication.title
```

After modifying assets or localization strings, regenerate with:
```bash
cd Core
swiftgen config run --config swiftgen.yml
```

### Custom UI Components

**CustomActionButton** (`Shared/Components/Buttons/`):
- Supports loading state with activity indicator
- Configurable corner radius, border, colors
- Automatic enabled/disabled styling

**CustomTextField** (`Shared/Components/TextFields/`):
- Inline floating placeholder animation
- Focus-based border color changes
- Secure text entry support
- Custom padding via text edge insets

### Networking via NetworkProvider

Located at `Shared/Network/NetworkProvider.swift`, this singleton wraps Alamofire:

```swift
NetworkProvider.shared.requestDecodable(
    url,
    method: .post,
    parameters: params,
    encoding: JSONEncoding.prettyPrinted,
    headers: headers
) { (response: AFDataResponse<ModelType>) in
    // Handle response
}
```

Supports both Decodable types and raw JSON responses.

### Factory Pattern for Dependency Injection

Each scene has a Factory that wires up all dependencies:
```swift
struct LoginEmailAuthFactory {
    func make() -> UIViewController {
        let router = LoginEmailAuthRouter()
        let view = LoginEmailAuthView()
        let presenter = LoginEmailAuthPresenter()
        let worker = LoginEmailAuthWorker()
        let interactor = LoginEmailAuthInteractor(
            presenter: presenter,
            worker: worker
        )
        let viewController = LoginEmailAuthViewController(
            router: router,
            interactor: interactor,
            view: view
        )
        router.presentedViewController = viewController
        return viewController
    }
}
```

### Delegation for View Communication

Views use weak delegates to communicate with ViewControllers:
```swift
protocol LoginEmailAuthDisplayDelegate: AnyObject {
    func didTouchContinue(email: String, password: String)
}

final class LoginEmailAuthView: UIView {
    weak var delegate: LoginEmailAuthDisplayDelegate?
}

extension LoginEmailAuthViewController: LoginEmailAuthDisplayDelegate {
    func didTouchContinue(email: String, password: String) {
        // Delegate to interactor
    }
}
```

### Alert Presentation

Use the custom alert extension in `UIViewControllerExtensions.swift`:
```swift
presentAlert(
    title: "Error",
    message: "Authentication failed",
    preferredStyle: .alert,
    actions: UIAlertAction(title: "OK", style: .default)
)
```

## Code Generation and Build Pipeline

### SwiftGen Configuration

The `swiftgen.yml` configures automatic generation of:

1. **Assets** from `Assets.xcassets` and `Colors.xcassets` → `Shared/Generated/Assets.swift`
2. **Localization** from `en.lproj/Localizable.strings` → `Shared/Generated/Localization.swift`

Never edit files in `Shared/Generated/` manually. Always regenerate after resource changes.

### Color Organization

Colors in `Colors.xcassets` are semantically organized:
- **Base Colors:** darkBaseColor, lightBaseColor, etc.
- **Text Colors:** primaryTextColor, secondaryTextColor
- **Special Colors:** brandColor, facebookColor, etc.

Access via: `Colors.darkBaseColor.color`

### Localization

Supports English (`en.lproj`) and Portuguese Brazil (`pt-BR.lproj`). Add new strings to `Localizable.strings` then regenerate with SwiftGen. Access via enum:
```swift
let title = Localization.Login.EmailAuthentication.title
```

## Creating a New VIPER Module

When adding a new feature module:

1. Create directory: `Sources/Modules/YourFeature/YourScene/`
2. Create these files following the naming pattern:
   - `YourSceneView.swift` (UIView subclass)
   - `YourSceneViewController.swift` (UIViewController subclass)
   - `YourSceneInteractor.swift` (if business logic needed)
   - `YourScenePresenter.swift` (if data formatting needed)
   - `YourSceneRouter.swift` (for navigation)
   - `YourSceneFactory.swift` (dependency injection)
   - `YourSceneWorker.swift` (if API calls needed)
   - `YourSceneUseCase.swift` (Request/Response models)

3. Define protocols for each component's interface
4. Wire dependencies in the Factory
5. Use delegation pattern for View → ViewController communication
6. Use protocol methods for ViewController → Interactor communication

## Current Work in Progress

Based on recent commits:
- Authentication structure is being built (Firebase/Auth was removed)
- NetworkProvider implementation is in progress
- Email authentication flow is scaffolded but incomplete (see TODOs in code)

## Important Files

- **Entry Point:** `Sources/AppDelegate.swift` - initializes Firebase, IQKeyboardManager, window
- **Network Layer:** `Sources/Shared/Network/NetworkProvider.swift` - Alamofire wrapper
- **Custom Components:** `Sources/Shared/Components/` - reusable UI elements
- **Extensions:** `Sources/Shared/Extensions/` - UIKit helper extensions
- **Generated Code:** `Sources/Shared/Generated/` - SwiftGen output (DO NOT EDIT)
- **Dependencies:** `Core/Podfile` - CocoaPods manifest
- **Linting Rules:** `Core/.swiftlint.yml` - SwiftLint configuration
- **Code Gen Config:** `Core/swiftgen.yml` - SwiftGen configuration

## Testing

- Test target: `uMovieTests`
- Location: `Core/uMovieTests/Sources/Modules/Login/uMovieTests.swift`
- Framework: XCTest
- Run tests via Xcode or `xcodebuild test`

## iOS Version Support

- Minimum: iOS 13.0
- Supported orientations: Portrait only (iPhone), all orientations (iPad)
