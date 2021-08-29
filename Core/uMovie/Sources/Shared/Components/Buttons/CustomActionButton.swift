import Foundation
import SnapKit
import UIKit

final class CustomActionButton: UIButton {

    // MARK: - Internal Properties

    var enabledBackgroundColor: UIColor = Colors.darkBaseColor.color
    var disabledBackgroundColor: UIColor?
    var cornerRadius: CGFloat = 24.0
    var fontSize: CGFloat = 17.0
    var fontWeight: UIFont.Weight = .semibold
    var loadingColor: UIColor = Colors.lightBaseColor.color
    var borderWidth: CGFloat = .zero
    var borderColor: UIColor = Colors.darkBaseColor.color

    lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.hidesWhenStopped = true
        return loading
    }()

    var isLoading: Bool = false {
        didSet {
            if isLoading {
                loadingView.color = loadingColor
                loadingView.frame = bounds
                loadingView.backgroundColor = enabledBackgroundColor

                loadingView.snp.makeConstraints { $0.edges.equalTo(self) }

                loadingView.startAnimating()
            } else {
                loadingView.stopAnimating()
            }
        }
    }

    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? enabledBackgroundColor : disabledBackgroundColor
        }
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.25,
                delay: .zero,
                options: [.beginFromCurrentState, .allowUserInteraction],
                animations: { self.alpha = self.isHighlighted ? 0.5 : 1 }
            )
        }
    }

    // MARK: - Lifecycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentMode = .scaleToFill
        contentHorizontalAlignment = .left

        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let imageViewWidth = imageView?.frame.width ?? .zero
        let titleLabelWidth = titleLabel?.frame.width ?? .zero
        let availableWidth = availableSpace.width - imageEdgeInsets.right - imageViewWidth - titleLabelWidth

        titleEdgeInsets = UIEdgeInsets(top: .zero, left: availableWidth / 2, bottom: .zero, right: .zero)
    }

    // MARK: - Private Methods

    private func setupUI() {
        addSubview(loadingView)

        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        adjustsImageWhenHighlighted = false

        titleLabel?.textAlignment = .center
        titleLabel?.font = .defaultSystem(withSize: fontSize, weight: fontWeight)

        let enabled = isEnabled
        isEnabled = enabled
    }
}
