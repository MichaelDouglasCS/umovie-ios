import Foundation
import SnapKit
import UIKit

protocol LoginEmailAuthDisplayDelegate: AnyObject {

}

protocol LoginEmailAuthDisplay: UIView {
    func configure(with delegate: LoginEmailAuthDisplayDelegate)
}

final class LoginEmailAuthView: UIView {

    // MARK: - Private Properties

    private weak var delegate: LoginEmailAuthDisplayDelegate?

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

// MARK: - Setup Constraints

extension LoginEmailAuthView {

    private func setupUI() {
        backgroundColor = .red
    }
}

// MARK: - LoginEmailAuthDisplay

extension LoginEmailAuthView: LoginEmailAuthDisplay {

    func configure(with delegate: LoginEmailAuthDisplayDelegate) {
        self.delegate = delegate
    }
}
