import Foundation
import UIKit

struct LoginEmailAuthFactory {

    func make() -> UIViewController {
        let router = LoginEmailAuthRouter()
        let view = LoginEmailAuthView()
        let viewController = LoginEmailAuthViewController(router: router, view: view)

        router.presentedViewController = viewController
        return viewController
    }
}
