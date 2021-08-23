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
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Private Methods

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = Colors.darkBaseColor.color
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationItem.backButtonTitle = ""
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
