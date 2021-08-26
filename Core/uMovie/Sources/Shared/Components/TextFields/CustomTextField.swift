import Foundation
import SnapKit
import UIKit

final class CustomTextField: UITextField {

    // MARK: - Internal Properties

    var cornerRadius: CGFloat = 6
    var borderWidth: CGFloat = 1.5
    var borderColor: UIColor = Colors.darkBaseColor.color
    var textEdgeInsets: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)

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

    // MARK: - Private Methods

    private func setupUI() {
        backgroundColor = .clear
        clipsToBounds = true

        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
}
