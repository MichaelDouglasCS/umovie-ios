import Foundation
import UIKit

struct LoginOptionsFactory {

    func make() -> UIViewController {
        let view = LoginOptionsView()
        let viewController = LoginOptionsViewController(view: view)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.setNavigationBarHidden(true, animated: false)
        return navigationViewController
    }
}
