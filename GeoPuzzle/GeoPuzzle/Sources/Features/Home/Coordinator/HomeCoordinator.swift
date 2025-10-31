import UIKit
import Combine

class HomeCoordinator: HomeCoordinatorProtocol {

    var cancellables = Set<AnyCancellable>()
    var parentCoordinator: MainTabBarCoordinatorProtocol?

    lazy var rootViewController: UIViewController = UIViewController()

    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: HomeViewController(coordinator: self))
        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .home(let screen):
            handleHomeFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }

    private func handleHomeFlow(for screen: HomeScreen, userData: [String: Any]?) {
        switch screen {
        case .initialScreen:
            navigationService.popToRoot(animated: true)
        case .doubleButtonScreen:
            navigationService.popToRoot(animated: true)
        }
    }

    func resetToRoot() -> Self {
        navigationService.popToRoot(animated: false)
        return self
    }
}
