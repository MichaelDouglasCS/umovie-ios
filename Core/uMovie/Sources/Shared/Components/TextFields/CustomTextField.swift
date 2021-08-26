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

    private func setupUI() {
        backgroundColor = Colors.textfieldColor.color
        clipsToBounds = true

        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = shouldHighlight ? highlightedBorderColor.cgColor : borderColor.cgColor
        layer.masksToBounds = true
    }

    private func setHighlight(_ highlight: Bool) {
        shouldHighlight = highlight
    }
}
