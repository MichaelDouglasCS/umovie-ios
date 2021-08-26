import Foundation
import UIKit

final class LoginOptionsViewController: UIViewController {

    // MARK: - Private Properties

    private let router: LoginOptionsRoutingLogic
    private let customView: LoginOptionsDisplay

    // MARK: - Initializers

    init(
        router: LoginOptionsRoutingLogic,
        view: LoginOptionsDisplay
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTranslucentNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar(false, animated: true)
    }
}

// MARK: - LoginDisplayDelegate

extension LoginOptionsViewController: LoginOptionsDisplayDelegate {

    func didTouchContinueWithApple() {
        router.presentAppleAuthentication()
    }

    func didTouchContinueWithFacebook() {
        router.presentFacebookAuthentication()
    }

    func didTouchContinueWithEmail() {
        router.presentEmailAuthentication()
    }
}
