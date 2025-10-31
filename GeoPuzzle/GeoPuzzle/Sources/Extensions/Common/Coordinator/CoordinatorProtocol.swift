import UIKit
import Combine

protocol CoordinatorProtocol: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    var cancellables: Set<AnyCancellable> { get set }

    func start() -> UIViewController
    func moveTo(flow: AppFlow, userData: [String: Any]?)
    @discardableResult func resetToRoot(animated: Bool) -> Self
}

extension CoordinatorProtocol {
    var navigationService: NavigationServicesProtocol {
        get {
            NavigationServices(
                navigationController: (rootViewController as? UINavigationController ?? UINavigationController())
            )
        }
    }

    func resetToRoot(animated: Bool) -> Self {
        navigationService.popToRoot(animated: animated)
        return self
    }
}
