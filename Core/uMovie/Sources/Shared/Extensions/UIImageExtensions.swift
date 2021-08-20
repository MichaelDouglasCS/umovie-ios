import Foundation
import UIKit

extension UIImage {

    func resizeImage(
        to size: CGSize,
        scale: CGFloat = UIScreen.main.scale,
        isOpaque: Bool = false,
        renderingMode: UIImage.RenderingMode = .alwaysTemplate
    ) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, isOpaque, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return (scaledImage ?? self).withRenderingMode(renderingMode)
    }
}
