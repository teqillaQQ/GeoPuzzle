import UIKit

final class NavigationServices: NavigationServicesProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pushVC(_ viewController: UIViewController, animated: Bool) {
        self.navigationController.pushViewController(viewController, animated: animated)
    }
    
    func popVC(_ viewController: UIViewController, animated: Bool) {
        if self.navigationController.viewControllers.contains(viewController) {
            self.navigationController.popToViewController(viewController, animated: animated)
        } else {
            self.navigationController.popToRootViewController(animated: animated)
        }
    }
    
    func popVC(animated: Bool = true) {
        self.navigationController.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        self.navigationController.popToRootViewController(animated: animated)
    }
}
