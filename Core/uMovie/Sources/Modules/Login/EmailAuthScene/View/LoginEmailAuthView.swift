import Foundation
import SnapKit
import UIKit

protocol LoginEmailAuthDisplayDelegate: AnyObject {

}

protocol LoginEmailAuthDisplay: UIView {
    func configure(with delegate: LoginEmailAuthDisplayDelegate)
}

final class LoginEmailAuthView: UIView {

    // MARK: - View Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.Login.EmailAuthentication.title
        label.font = .defaultSystem(withSize: 17)
        label.textColor = Colors.primaryTextColor.color
        return label
    }()

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
        backgroundColor = Colors.lightBaseColor.color
        setupTitleConstraints()
    }

    private func setupTitleConstraints() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(self).offset(16)
            make.trailing.greaterThanOrEqualTo(self).offset(-16)
        }
    }
}

// MARK: - LoginEmailAuthDisplay

extension LoginEmailAuthView: LoginEmailAuthDisplay {

    func configure(with delegate: LoginEmailAuthDisplayDelegate) {
        self.delegate = delegate
    }
}
