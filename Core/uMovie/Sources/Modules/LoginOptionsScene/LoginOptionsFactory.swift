import Foundation
import UIKit

struct LoginOptionsFactory {

    func make() -> UIViewController {
        let view = LoginOptionsView()
        let viewController = LoginOptionsViewController(view: view)
        return viewController
    }
}
