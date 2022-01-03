import Firebase
import IQKeyboardManager
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Internal Properties

    var window: UIWindow?

    // MARK: - Internal Methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupDependencies()
        setupWindow()
        return true
    }

    // MARK: - Private Methods

    private func setupDependencies() {
        FirebaseApp.configure()
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().toolbarTintColor = Colors.darkBaseColor.color
    }

    private func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { return }

        let loginOptionsViewController = LoginOptionsFactory().make()
        let navigationViewController = UINavigationController(rootViewController: loginOptionsViewController)

        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
    }
}
