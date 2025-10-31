import Foundation

class DeepLinkCoordinator: DeepLinkCoordinatorProtocol {

    func handleDeeplink(deepLink: String) {
        print("")
    }

    var parentCoordinator: MainTabBarCoordinatorProtocol?

    init(mainBaseCoordinator: MainTabBarCoordinatorProtocol) {
        self.parentCoordinator = mainBaseCoordinator
    }
}
