import Foundation

protocol DeepLinkCoordinatorProtocol: FlowCoordinator {
    func handleDeeplink(deepLink: String)
}
