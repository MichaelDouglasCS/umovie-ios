import Foundation
import UIKit

// MARK: - Navigation Bar Configurations

extension UIViewController {

    func setupNavigationBar() {
        guard let navigationController = self.navigationController else { return }

        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.tintColor = Colors.darkBaseColor.color
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
        navigationItem.backButtonTitle = ""
    }

    func showNavigationBar(_ show: Bool, animated: Bool) {
        guard let navigationController = self.navigationController else { return }
        navigationController.setNavigationBarHidden(show, animated: animated)
    }
}
