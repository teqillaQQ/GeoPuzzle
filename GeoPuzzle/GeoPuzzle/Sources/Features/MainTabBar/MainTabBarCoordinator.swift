import UIKit
import Combine

final class MainTabBarCoordinator: MainTabBarCoordinatorProtocol {

    lazy var rootViewController: UIViewController = UITabBarController()

    lazy var aboutCoordinator: AboutCoordinatorProtocol = AboutCoordinator()
    lazy var profileCoordinator: ProfileCoordinatorProtocol = ProfileCoordinator()
    lazy var quizCoordinator: QuizCoordinatorProtocol = QuizCoordinator()
    lazy var deepLinkCoordinator: DeepLinkCoordinatorProtocol = DeepLinkCoordinator(mainBaseCoordinator: self)

    var cancellables = Set<AnyCancellable>()
    var parentCoordinator: MainTabBarCoordinatorProtocol?


    func start() -> UIViewController {
        let aboutViewController = aboutCoordinator.start()
        aboutCoordinator.parentCoordinator = self
        aboutViewController.tabBarItem = UITabBarItem(title: "О приложении", image: UIImage(systemName: "info.circle"), tag: 0)

        let profileViewController = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(title: "Личный кабинет", image: UIImage(systemName: "person.circle"), tag: 1)

        let quizViewController = quizCoordinator.start()
        quizCoordinator.parentCoordinator = self
        quizViewController.tabBarItem = UITabBarItem(title: "Викторина", image: UIImage(systemName: "questionmark.circle.fill"), tag: 2)

        (rootViewController as? UITabBarController)?.viewControllers = [
            quizViewController,
            aboutViewController,
            profileViewController
        ]
        
        (rootViewController as? UITabBarController)?.selectedIndex = 0

        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .about:
            goToAboutFlow(flow)
        case .profile:
            goToProfileFlow(flow)
        case .quiz:
            goToQuizFlow(flow)
        }
    }

    private func goToAboutFlow(_ flow: AppFlow) {
        aboutCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }

    private func goToProfileFlow(_ flow: AppFlow) {
        profileCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 2

    }

    private func goToQuizFlow(_ flow: AppFlow) {
        quizCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }

    func handleDeepLink(text: String) {
        deepLinkCoordinator.handleDeeplink(deepLink: text)
    }

    func resetToRoot() -> Self {
        quizCoordinator.resetToRoot(animated: false)
        moveTo(flow: .quiz(.firstScreen), userData: nil)
        return self
    }
}

enum AppFlow {
    case about(AboutScreen)
    case profile(ProfileScreen)
    case quiz(QuizScreen)
}

enum AboutScreen {
    case initialScreen
    case doubleButtonScreen
}

enum ProfileScreen {
    case firstScreen
    case secondScreen
    case thirdScreen
}

enum QuizScreen {
    case firstScreen
    case secondScreen
    case thirdScreen
}
