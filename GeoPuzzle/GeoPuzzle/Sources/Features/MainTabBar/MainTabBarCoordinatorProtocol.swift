protocol MainTabBarCoordinatorProtocol: CoordinatorProtocol {
    var aboutCoordinator: AboutCoordinatorProtocol { get }
    var profileCoordinator: ProfileCoordinatorProtocol { get }
    var quizCoordinator: QuizCoordinatorProtocol { get }
    var deepLinkCoordinator: DeepLinkCoordinatorProtocol { get }

    func handleDeepLink(text: String)
}

protocol AboutBaseCoordinated {
    var coordinator: AboutCoordinatorProtocol? { get }
}

protocol ProfileBaseCoordinated {
    var coordinator: ProfileCoordinatorProtocol? { get }
}

protocol QuizBaseCoordinated {
    var coordinator: QuizCoordinatorProtocol { get }
}
