import Foundation
import SnapKit
import UIKit

protocol LoginEmailAuthDisplayDelegate: AnyObject {
    func didTouchContinueWith(email: String, password: String)
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
        textField.clearButtonMode = .whileEditing
        textField.enablesReturnKeyAutomatically = true
        textField.placeholder = Localization.General.email
        textField.tintColor = Colors.darkBaseColor.color
        return textField
    }()

    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.textContentType = .password
        textField.keyboardType = .alphabet
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.isSecureTextEntry = true
        textField.placeholder = Localization.General.password
        textField.tintColor = Colors.darkBaseColor.color
        textField.rightView = seePasswordButton
        textField.rightViewMode = .always
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

    private lazy var seePasswordButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setImage(Images.closeEyeIcon.image.resizeImage(to: .init(width: 32, height: 16)), for: .selected)
        button.setImage(Images.openEyeIcon.image.resizeImage(to: .init(width: 32, height: 16)), for: .normal)
        button.imageEdgeInsets = .init(top: .zero, left: .zero, bottom: .zero, right: 8)
        button.addTarget(self, action: #selector(didTouchSeePasswordButton), for: .touchUpInside)
        button.tintColor = Colors.separatorColor.color
        button.cornerRadius = .zero
        button.enabledBackgroundColor = .clear
        button.isEnabled = true
        return button
    }()

    private lazy var forgotPasswordButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setTitle(Localization.Login.EmailAuthentication.forgotMyPasswordTitle, for: .normal)
        button.setTitleColor(Colors.primaryTextColor.color, for: .normal)
        button.addTarget(self, action: #selector(didTouchForgotPasswordButton), for: .touchUpInside)
        button.fontSize = 13
        button.fontWeight = .regular
        button.cornerRadius = .zero
        button.enabledBackgroundColor = .clear
        button.isEnabled = true
        return button
    }()

    private lazy var continueButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setTitle(Localization.General.continue, for: .normal)
        button.setTitleColor(Colors.lightBaseColor.color, for: .normal)
        button.addTarget(self, action: #selector(didTouchContinueButton), for: .touchUpInside)
        button.fontWeight = .bold
        button.loadingColor = Colors.lightBaseColor.color
        button.isEnabled = true
        return button
    }()

    private lazy var createAccountButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setTitle(Localization.General.createAccount, for: .normal)
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

    @objc private func didTouchSeePasswordButton(_ sender: CustomActionButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }

    @objc private func didTouchForgotPasswordButton(_ sender: CustomActionButton) {

    }

    @objc private func didTouchContinueButton(_ sender: CustomActionButton) {

        if let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            delegate?.didTouchContinueWith(email: email, password: password)
        } else {
            let topMostViewController = UIApplication.shared.topMostViewController()
            topMostViewController?.presentAlert(
                title: Localization.Alert.ops,
                message: Localization.Alert.EmptyField.message,
                preferredStyle: .alert,
                actions: .init(title: Localization.General.gotIt, style: .default)
            )
        }
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
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(self).offset(16)
            make.trailing.greaterThanOrEqualTo(self).offset(-16)
        }
    }

    private func setupTextFieldsConstraints() {
        addSubview(textFieldStackView)

        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }

        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }

    private func setupButtonsConstraints() {
        addSubview(forgotPasswordButton)
        addSubview(loginButtonsStackView)

        forgotPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.top.equalTo(textFieldStackView.snp.bottom).offset(4)
            make.leading.equalTo(textFieldStackView).offset(2)
        }

        loginButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(30)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }

        continueButton.snp.makeConstraints { $0.height.equalTo(48) }
    }
}

// MARK: - LoginEmailAuthDisplay

extension LoginEmailAuthView: LoginEmailAuthDisplay {

    func configure(with delegate: LoginEmailAuthDisplayDelegate) {
        self.delegate = delegate
    }
}
