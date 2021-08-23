import Foundation
import UIKit

final class LoginOptionsViewController: UIViewController {

    // MARK: - Private Properties

    private let customView: LoginOptionsDisplay

    // MARK: - Initializers

    init(
        view: LoginOptionsDisplay
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

extension LoginOptionsViewController: LoginOptionsDisplayDelegate {

    func didTouchContinueWithApple() {

    }

    func didTouchContinueWithFacebook() {

    }

    func didTouchContinueWithEmail() {

    }
}
