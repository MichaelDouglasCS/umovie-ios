import Foundation
import UIKit

struct LoginOptionsFactory {

    func make() -> UIViewController {
        let router = LoginOptionsRouter()
        let view = LoginOptionsView()
        let viewController = LoginOptionsViewController(router: router, view: view)

        router.presentedViewController = viewController
        return viewController
    }
}
