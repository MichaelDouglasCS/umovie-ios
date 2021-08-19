//
//  LoginView.swift
//  uMovie
//
//  Created by Michael Douglas on 18/08/21.
//

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
    }

    // MARK: - View Properties

    private lazy var brandImageView: UIImageView = {
        let imageView = UIImageView(image: Image.uMovieLogo)
        return imageView
    }()

    private lazy var brandNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center

        let font = Font.system(withSize: 55, weight: .regular, design: .rounded)
        let attributedString = NSMutableAttributedString(string: "uMovie", attributes: [NSAttributedString.Key.font: font])
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: Color.brandColor], range: .init(location: 0, length: 1))

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

    // MARK: - Private Properties

    private var delegate: LoginDisplayDelegate?

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
        backgroundColor = Color.backgroundColor

        setupBrandContraints()
    }

    private func setupBrandContraints() {
        addSubview(brandStackView)

        brandImageView.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(116)
        }

        brandStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
        }
    }
}

// MARK: - LoginViewDisplayProtocol

extension LoginView: LoginDisplay {

    func configure(with delegate: LoginDisplayDelegate) {
        self.delegate = delegate
    }
}
