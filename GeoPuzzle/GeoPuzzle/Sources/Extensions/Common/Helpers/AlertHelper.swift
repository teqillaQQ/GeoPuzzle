import UIKit

final class AlertHelper {
    static func showAlert(
        title: String? = nil,
        message: String,
        on viewController: UIViewController? = UIApplication.topViewController()
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
