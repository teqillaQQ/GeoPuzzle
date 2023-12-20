import UIKit

extension UIApplication {
    final class func topViewController(
        _ viewController: UIViewController? = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first(where: \.isKeyWindow)?
            .rootViewController
    ) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        } else if let tab = viewController as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(selected)
        } else if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
}

