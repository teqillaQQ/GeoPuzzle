import UIKit
import Combine

class ProfileCoordinator: ProfileCoordinatorProtocol {

    var cancellables = Set<AnyCancellable>()
    var parentCoordinator: MainTabBarCoordinatorProtocol?

    var rootViewController: UIViewController = UIViewController()

    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: ProfileViewController(coordinator: self))
        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .profile(let screen):
            handleProfileFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }

    private func handleProfileFlow(for screen: ProfileScreen, userData: [String : Any]? = nil) {
        switch screen {
        case .firstScreen:
            resetToRoot(animated: false)
        case .secondScreen:
            resetToRoot(animated: false)
        case .thirdScreen:
            resetToRoot(animated: false)
        }
    }

    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationService.popToRoot(animated: animated)
        return self
    }
}
