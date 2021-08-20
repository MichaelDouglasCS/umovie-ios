import Foundation
import SnapKit
import UIKit

protocol LoginDisplayDelegate: AnyObject {
    func didTouchContinueWithApple()
    func didTouchContinueWithFacebook()
    func didTouchContinueWithEmail()
}

protocol LoginDisplay: UIView {
    func configure(with delegate: LoginDisplayDelegate)
}

final class LoginView: UIView {

    private struct Configuration {
        static let brandSpacing: CGFloat = 8
        static let padding: CGFloat = 30
    }

    // MARK: - View Properties

    private lazy var brandImageView: UIImageView = {
        let imageView = UIImageView(image: Images.umovieIcon.image)
        return imageView
    }()

    private lazy var brandNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center

        let title = Localization.Brand.title
        let font = Fonts.defaultSystem(withSize: 55, weight: .regular, design: .rounded)
        let attributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: font])
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: Colors.brandColor.color], range: .init(location: 0, length: 1))

        label.attributedText = attributedString
        return label
    }()

    private lazy var brandStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [brandImageView, brandNameLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Configuration.brandSpacing
        return stackView
    }()

    private lazy var brandIllustrationImageView: UIImageView = {
        let imageView = UIImageView(image: Images.brandIllustration.image)
        return imageView
    }()

    private lazy var continueLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.Login.ContinueOption.title
        label.font = Fonts.defaultSystem(withSize: 16.0)
        label.textColor = Colors.subtitleTextColor.color
        return label
    }()

    private lazy var continueWithAppleButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setTitle(Localization.Login.ContinueOption.apple, for: .normal)
        button.setTitleColor(Colors.offColor.color, for: .normal)
        button.setImage(Images.appleIcon.image.resizeImage(to: .init(width: 18, height: 22)), for: .normal)
        button.imageEdgeInsets = .init(top: 12, left: 14, bottom: 12, right: .zero)
        button.addTarget(self, action: #selector(didTouchContinueWithAppleButton), for: .touchUpInside)
        button.tintColor = Colors.offColor.color
        button.isEnabled = true
        return button
    }()

    private lazy var continueWithFacebookButton: CustomActionButton = {
        let button = CustomActionButton()
        button.setTitle(Localization.Login.ContinueOption.facebook, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(Images.facebookIcon.image.resizeImage(to: .init(width: 12, height: 22)), for: .normal)
        button.imageEdgeInsets = .init(top: 12, left: 16, bottom: 12, right: .zero)
        button.addTarget(self, action: #selector(didTouchContinueWithFacebookButton), for: .touchUpInside)
        button.tintColor = .white
        button.loadingColor = .white
        button.enabledBackgroundColor = Colors.facebookColor.color
        button.isEnabled = true
        return button
    }()

    private lazy var continueWithEmailButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Fonts.defaultSystem(withSize: 17.0, weight: .semibold)
        button.setTitle(Localization.Login.ContinueOption.email, for: .normal)
        return button
    }()

    private lazy var continueOptionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [continueWithAppleButton, continueWithFacebookButton, continueWithEmailButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()

    // MARK: - Private Properties

    private weak var delegate: LoginDisplayDelegate?

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Actions

    @objc private func didTouchContinueWithAppleButton() {
        continueWithAppleButton.isLoading = !continueWithAppleButton.isLoading
    }

    @objc private func didTouchContinueWithFacebookButton() {

    }

    private func didTouchContinueWithEmailButton() {

    }
}

// MARK: - Setup Constraints

extension LoginView {

    private func setupUI() {
        backgroundColor = Colors.offColor.color
        setupBrandContraints()
        setupContinueOptionsConstraints()
    }

    private func setupBrandContraints() {
        addSubview(brandStackView)
        addSubview(brandIllustrationImageView)

        brandImageView.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(116)
        }

        brandStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(self).offset(Configuration.padding)
            make.trailing.equalTo(self).offset(-Configuration.padding)
        }

        brandIllustrationImageView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(241)
            make.height.equalTo(230)
        }
    }

    private func setupContinueOptionsConstraints() {
        addSubview(continueLabel)
        addSubview(continueOptionsStackView)

        continueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(brandIllustrationImageView.snp.bottom).offset(Configuration.padding)
        }

        continueOptionsStackView.snp.makeConstraints { make in
            make.top.equalTo(continueLabel.snp.bottom).offset(16)
            make.centerX.equalTo(self)
            make.width.equalTo(300)
        }

        continueWithAppleButton.snp.makeConstraints({ $0.height.equalTo(48) })
    }
}

// MARK: - LoginViewDisplayProtocol

extension LoginView: LoginDisplay {

    func configure(with delegate: LoginDisplayDelegate) {
        self.delegate = delegate
    }
}
