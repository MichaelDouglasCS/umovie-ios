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
        label.font = .defaultSystem(withSize: 20)
        label.textColor = Colors.darkBaseColor.color
        label.numberOfLines = 2
        return label
    }()

    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.enablesReturnKeyAutomatically = true
        textField.placeholder = Localization.General.Email.title
        textField.tintColor = Colors.darkBaseColor.color
        return textField
    }()

    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.textContentType = .password
        textField.keyboardType = .default
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.isSecureTextEntry = true
        textField.placeholder = Localization.General.Password.title
        textField.tintColor = Colors.darkBaseColor.color
        return textField
    }()

    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()

    private lazy var continueButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setTitle(Localization.General.Continue.title, for: .normal)
        button.setTitleColor(Colors.lightBaseColor.color, for: .normal)
        button.addTarget(self, action: #selector(didTouchContinueButton), for: .touchUpInside)
        button.fontWeight = .bold
        button.loadingColor = Colors.lightBaseColor.color
        button.isEnabled = true
        return button
    }()

    private lazy var createAccountButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setTitle(Localization.General.CreateAccount.title, for: .normal)
        button.setTitleColor(Colors.darkBaseColor.color, for: .normal)
        button.addTarget(self, action: #selector(didTouchCreateAccountButton), for: .touchUpInside)
        button.borderWidth = 1.5
        button.fontWeight = .bold
        button.loadingColor = Colors.darkBaseColor.color
        button.enabledBackgroundColor = Colors.lightBaseColor.color
        button.isEnabled = true
        return button
    }()

    private lazy var loginButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [continueButton, createAccountButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
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

    // MARK: - Actions

    @objc private func didTouchContinueButton(_ sender: CustomActionButton) {

    }

    @objc private func didTouchCreateAccountButton(_ sender: CustomActionButton) {

    }
}

// MARK: - Setup Constraints

extension LoginEmailAuthView {

    private func setupUI() {
        backgroundColor = Colors.lightBaseColor.color
        setupTitleConstraints()
        setupTextFieldsConstraints()
        setupButtonsConstraints()
    }

    private func setupTitleConstraints() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(self).offset(16)
            make.trailing.greaterThanOrEqualTo(self).offset(-16)
        }
    }

    private func setupTextFieldsConstraints() {
        addSubview(textFieldStackView)

        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }

        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }

    private func setupButtonsConstraints() {
        addSubview(loginButtonsStackView)

        loginButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(50)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }

        continueButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
}

// MARK: - LoginEmailAuthDisplay

extension LoginEmailAuthView: LoginEmailAuthDisplay {

    func configure(with delegate: LoginEmailAuthDisplayDelegate) {
        self.delegate = delegate
    }
}
