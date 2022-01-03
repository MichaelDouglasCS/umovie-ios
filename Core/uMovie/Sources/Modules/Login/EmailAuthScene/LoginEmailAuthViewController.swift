import Foundation
import UIKit

final class LoginEmailAuthViewController: UIViewController {

    // MARK: - Private Properties

    private let router: LoginEmailAuthRoutingLogic
    private let interactor: LoginEmailAuthBusinessLogic
    private let customView: LoginEmailAuthDisplay

    // MARK: - Initializers

    init(
        router: LoginEmailAuthRoutingLogic,
        interactor: LoginEmailAuthBusinessLogic,
        view: LoginEmailAuthDisplay
    ) {
        self.router = router
        self.interactor = interactor
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func loadView() {
        view = customView
        customView.configure(with: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - LoginDisplayDelegate

extension LoginEmailAuthViewController: LoginEmailAuthDisplayDelegate {

    func didTouchForgotPassword() {
        // TODO - Handle Forgot Password
    }

    func didTouchContinue(email: String, password: String) {
        interactor.authenticate(request: .init(email: email, password: password))
    }

    func didTouchCreateAccount() {
        // TODO - Handle Create Account
    }
}
