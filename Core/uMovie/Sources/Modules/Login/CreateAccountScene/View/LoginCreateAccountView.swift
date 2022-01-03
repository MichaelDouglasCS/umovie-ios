import Foundation
import SnapKit
import UIKit

protocol LoginCreateAccountDisplayDelegate: AnyObject {

}

protocol LoginCreateAccountDisplay: UIView {
    func configure(with delegate: LoginCreateAccountDisplayDelegate)
}

final class LoginCreateAccountView: UIView {

    // MARK: - Private Properties

    private weak var delegate: LoginCreateAccountDisplayDelegate?

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Actions

    @objc private func didTouchCreateAccountButton(_ sender: CustomActionButton) {

    }
}

// MARK: - Setup Constraints

extension LoginCreateAccountView {

    private func setupUI() {
        backgroundColor = Colors.lightBaseColor.color
    }
}

// MARK: - LoginCreateAccountDisplay

extension LoginCreateAccountView: LoginCreateAccountDisplay {

    func configure(with delegate: LoginCreateAccountDisplayDelegate) {
        self.delegate = delegate
    }
}
