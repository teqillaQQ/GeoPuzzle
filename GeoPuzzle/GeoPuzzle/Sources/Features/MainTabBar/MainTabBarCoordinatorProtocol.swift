protocol MainTabBarCoordinatorProtocol: CoordinatorProtocol {
    var homeCoordinator: HomeCoordinatorProtocol { get }
    var ordersCoordinator: OrdersCoordinatorProtocol { get }
    var quizCoordinator: QuizCoordinatorProtocol { get }
    var deepLinkCoordinator: DeepLinkCoordinatorProtocol { get }

    func handleDeepLink(text: String)
}

protocol HomeBaseCoordinated {
    var coordinator: HomeCoordinatorProtocol? { get }
}

protocol OrdersBaseCoordinated {
    var coordinator: OrdersCoordinatorProtocol? { get }
}

protocol QuizBaseCoordinated {
    var coordinator: QuizCoordinatorProtocol { get }
}
