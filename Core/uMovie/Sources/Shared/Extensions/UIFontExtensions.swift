import Foundation
import UIKit

extension UIFont {

    static func defaultSystem(
        withSize size: CGFloat,
        weight: UIFont.Weight = .regular,
        design: UIFontDescriptor.SystemDesign = .rounded
    ) -> UIFont {
        let font: UIFont = .systemFont(ofSize: size, weight: weight)
        guard let roundedFontDescriptor = font.fontDescriptor.withDesign(design) else { return font }
        return .init(descriptor: roundedFontDescriptor, size: size)
    }
}
