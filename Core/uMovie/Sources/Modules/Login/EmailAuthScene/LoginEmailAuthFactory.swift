import Foundation
import UIKit

struct LoginEmailAuthFactory {

    func make() -> UIViewController {
        let router = LoginEmailAuthRouter()
        let view = LoginEmailAuthView()
        let presenter = LoginEmailAuthPresenter()
        let worker = LoginEmailAuthWorker()
        let interactor = LoginEmailAuthInteractor(presenter: presenter, worker: worker)

        let viewController = LoginEmailAuthViewController(
            router: router,
            interactor: interactor,
            view: view
        )

        router.presentedViewController = viewController
        return viewController
    }
}
