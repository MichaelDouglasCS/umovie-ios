import Foundation
import UIKit

// MARK: - Navigation Bar Configurations

extension UIViewController {

    func setupTranslucentNavigationBar() {
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

// MARK: - Alert Controller

extension UIViewController {

    @discardableResult func presentAlert(
        title: String?,
        message: String?,
        preferredStyle: UIAlertController.Style,
        actions: UIAlertAction...,
        completion: (() -> Void)? = nil
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { alert.addAction($0) }

        DispatchQueue.main.async { self.present(alert, animated: true, completion: completion) }

        return alert
    }
}
