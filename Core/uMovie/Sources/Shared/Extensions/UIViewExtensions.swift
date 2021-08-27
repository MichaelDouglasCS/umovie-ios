import Foundation
import UIKit

extension UIView {

    func applyTransform(withScale scale: CGFloat, anchorPoint: CGPoint) {
        let xPadding = (scale - 1) * (anchorPoint.x - 0.5) * bounds.width
        let yPadding = (scale - 1) * (anchorPoint.y - 0.5) * bounds.height
        transform = .init(scaleX: scale, y: scale).translatedBy(x: xPadding, y: yPadding)
    }
}
