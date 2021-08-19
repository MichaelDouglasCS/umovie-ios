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

        let font = Fonts.defaultSystem(withSize: 55, weight: .regular, design: .rounded)
        let attributedString = NSMutableAttributedString(string: "uMovie", attributes: [NSAttributedString.Key.font: font])
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
        label.font = Fonts.defaultSystem(withSize: 17.0)
        label.textColor = Colors.subtitleColor.color
        return label
    }()

    private lazy var continueWithAppleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar com a Apple", for: .normal)
        button.setImage(Images.appleIcon.image, for: .normal)
        return button
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
}

// MARK: - Setup Constraints

extension LoginView {

    private func setupUI() {
        backgroundColor = Colors.backgroundColor.color
        setupBrandContraints()
        setupContinueLabelConstraints()
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

    private func setupContinueLabelConstraints() {
        addSubview(continueLabel)

        continueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(brandIllustrationImageView.snp.bottom).offset(Configuration.padding)
        }
    }
}

// MARK: - LoginViewDisplayProtocol

extension LoginView: LoginDisplay {

    func configure(with delegate: LoginDisplayDelegate) {
        self.delegate = delegate
    }
}
