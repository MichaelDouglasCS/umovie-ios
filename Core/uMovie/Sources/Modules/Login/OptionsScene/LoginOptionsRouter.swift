import Foundation
import UIKit

protocol LoginOptionsRoutingLogic: AnyObject {
    func presentAppleAuthentication()
    func presentFacebookAuthentication()
    func presentEmailAuthentication()
}

final class LoginOptionsRouter: LoginOptionsRoutingLogic {

    // MARK: - Internal Properties

    weak var presentedViewController: UIViewController?

    // MARK: - Internal Methods

    func presentAppleAuthentication() {
        print(#function)
    }

    func presentFacebookAuthentication() {
        print(#function)
    }

    func presentEmailAuthentication() {
        let viewController = LoginEmailAuthFactory().make()
        presentedViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
