import Foundation
import UIKit

// MARK: - Top Most ViewController

extension UIApplication {

    func topMostViewController() -> UIViewController? {
        let rootViewController = windows.first { $0.isKeyWindow }?.rootViewController
        return topMostViewController(from: rootViewController)
    }

    private func topMostViewController(from baseViewController: UIViewController?) -> UIViewController? {

        if let navigation = baseViewController as? UINavigationController {
            return topMostViewController(from: navigation.visibleViewController)
        }

        if let tabBar = baseViewController as? UITabBarController,
           let selected = tabBar.selectedViewController {
            return topMostViewController(from: selected)
        }

        if let presented = baseViewController?.presentedViewController {
            return topMostViewController(from: presented)
        }

        if let childViewController = baseViewController?.children.last {
            return topMostViewController(from: childViewController)
        }

        return baseViewController
    }
}
