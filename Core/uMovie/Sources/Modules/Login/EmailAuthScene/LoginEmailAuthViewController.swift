import Foundation
import UIKit

final class LoginEmailAuthViewController: UIViewController {

    // MARK: - Private Properties

    private let router: LoginEmailAuthRoutingLogic
    private let customView: LoginEmailAuthDisplay

    // MARK: - Initializers

    init(
        router: LoginEmailAuthRoutingLogic,
        view: LoginEmailAuthDisplay
    ) {
        self.router = router
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

extension LoginEmailAuthViewController: LoginEmailAuthDisplayDelegate {

}
