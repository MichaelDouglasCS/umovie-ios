import Foundation
import UIKit

struct Font {

    static func system(
        withSize size: CGFloat,
        weight: UIFont.Weight = .regular,
        design: UIFontDescriptor.SystemDesign = .default
    ) -> UIFont {
        let font: UIFont = .systemFont(ofSize: size, weight: weight)
        guard let roundedFontDescriptor = font.fontDescriptor.withDesign(design) else { return font }
        return .init(descriptor: roundedFontDescriptor, size: size)
    }
}
