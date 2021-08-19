import Foundation
import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Private Properties

    private let customView: LoginDisplay

    // MARK: - Initializers

    init(
        view: LoginDisplay
    ) {
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
}

// MARK: - LoginDisplayDelegate

extension LoginViewController: LoginDisplayDelegate {

    func didTouchContinueWithApple() {

    }

    func didTouchContinueWithFacebook() {

    }

    func didTouchContinueWithEmail() {

    }
}
