import Foundation
import UIKit

struct LoginFactory {

    func make() -> UIViewController {
        let view = LoginView()
        let viewController = LoginViewController(view: view)
        return viewController
    }
}
