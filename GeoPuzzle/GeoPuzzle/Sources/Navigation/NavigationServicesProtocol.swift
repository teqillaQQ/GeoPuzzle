import UIKit

protocol NavigationServicesProtocol {
    func pushVC(_ viewController: UIViewController, animated: Bool)
    func popVC(_ viewController: UIViewController, animated: Bool)
    func popVC(animated: Bool)
    func popToRoot(animated: Bool)
}

extension NavigationServicesProtocol {
    func pushVC(_ viewController: UIViewController, animated: Bool = true) {
        pushVC(viewController, animated: animated)
    }

    func popVC(_ vc: UIViewController, animated: Bool = true) {
        popVC(vc, animated: animated)
    }

    func popVC(animated: Bool = true) {
        popVC(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        popToRoot(animated: animated)
    }
}
