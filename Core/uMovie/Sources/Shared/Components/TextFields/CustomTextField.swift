import Foundation
import SnapKit
import UIKit

final class CustomTextField: UITextField {

    // MARK: - Internal Properties

    var cornerRadius: CGFloat = 6
    var borderWidth: CGFloat = 1.5
    var borderColor: UIColor = Colors.separatorColor.color
    var highlightedBorderColor: UIColor = Colors.darkBaseColor.color
    var textEdgeInsets: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)

    // MARK: - Private Properties

    private var shouldHighlight: Bool = false

    private lazy var backgroundView: UIView = {
        let view = UIView(frame: frame)
        return view
    }()

    private lazy var inlinePlaceholderContainer: UIView = {
        let container = UIView()
        container.backgroundColor = Colors.textfieldColor.color
        container.layer.cornerRadius = 4
        container.layer.masksToBounds = true
        return container
    }()

    private lazy var inlinePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = placeholder
        label.textColor = highlightedBorderColor
        label.font = font
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private var inlinePlaceholderLeadingConstraint: Constraint?
    private var inlinePlaceholderCenterYConstraint: Constraint?

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupBackgroundView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    // MARK: - Internal Methods

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textEdgeInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textEdgeInsets)
    }

    override func becomeFirstResponder() -> Bool {
        defer { setHighlight(true) }
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        defer { setHighlight(false) }
        return super.resignFirstResponder()
    }

    // MARK: - Private Methods

    private func setupBackgroundView() {
        addSubview(backgroundView)

        backgroundView.isUserInteractionEnabled = false
        backgroundView.snp.makeConstraints { $0.edges.equalTo(self) }
    }

    private func setupUI() {
        backgroundView.backgroundColor = Colors.textfieldColor.color

        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.layer.borderWidth = borderWidth
        backgroundView.layer.borderColor = shouldHighlight ? highlightedBorderColor.cgColor : borderColor.cgColor
        rightView?.tintColor = shouldHighlight ? highlightedBorderColor : borderColor
    }

    private func setHighlight(_ highlight: Bool) {
        shouldHighlight = highlight
        shouldHighlightInlinePlaceholder(highlight)
    }

    private func shouldHighlightInlinePlaceholder(_ highlight: Bool) {
        let inlineLeading: CGFloat = textEdgeInsets.left - 4

        if highlight {
            inlinePlaceholderContainer.addSubview(inlinePlaceholderLabel)
            addSubview(inlinePlaceholderContainer)

            inlinePlaceholderContainer.snp.makeConstraints { make in
                inlinePlaceholderLeadingConstraint = make.leading.equalTo(self).offset(inlineLeading).constraint
                inlinePlaceholderCenterYConstraint = make.centerY.equalTo(self).constraint
            }

            inlinePlaceholderLabel.snp.makeConstraints { make in
                make.top.equalTo(inlinePlaceholderContainer)
                make.leading.equalTo(inlinePlaceholderContainer).offset(4)
                make.trailing.equalTo(inlinePlaceholderContainer).offset(-4)
                make.bottom.equalTo(inlinePlaceholderContainer)
            }

            layoutIfNeeded()

            UIView.animate(withDuration: 0.25, delay: .zero, options: .curveEaseOut) {
                self.inlinePlaceholderCenterYConstraint?.update(offset: -self.frame.height / 2)
                self.inlinePlaceholderLeadingConstraint?.update(offset: inlineLeading)
                self.inlinePlaceholderContainer.applyTransform(withScale: 0.75, anchorPoint: .init(x: 1, y: 1))
                self.inlinePlaceholderContainer.alpha = 1.0
                self.placeholder = nil
                self.layoutIfNeeded()
            }
        } else {

            UIView.animate(withDuration: 0.25, delay: .zero, options: .curveEaseOut) {
                self.inlinePlaceholderLeadingConstraint?.update(offset: inlineLeading)
                self.inlinePlaceholderCenterYConstraint?.update(offset: 0.0)
                self.inlinePlaceholderContainer.transform = .identity
                self.inlinePlaceholderContainer.alpha = 0.3
                self.layoutIfNeeded()
            } completion: { _ in
                self.placeholder = self.inlinePlaceholderLabel.text
                self.inlinePlaceholderContainer.removeFromSuperview()
            }
        }
    }
}
