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
        self.setupWindow()
        return true
    }

    // MARK: - Private Methods

    private func setupWindow() {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { return }

        let loginView = LoginFactory().make()
        window.rootViewController = loginView
        window.makeKeyAndVisible()
    }
}
