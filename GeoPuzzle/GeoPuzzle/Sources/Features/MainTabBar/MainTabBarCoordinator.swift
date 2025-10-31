import UIKit
import Combine

final class MainTabBarCoordinator: MainTabBarCoordinatorProtocol {

    lazy var rootViewController: UIViewController = UITabBarController()

    lazy var homeCoordinator: HomeCoordinatorProtocol = HomeCoordinator()
    lazy var ordersCoordinator: OrdersCoordinatorProtocol = OrdersCoordinator()
    lazy var quizCoordinator: QuizCoordinatorProtocol = QuizCoordinator()
    lazy var deepLinkCoordinator: DeepLinkCoordinatorProtocol = DeepLinkCoordinator(mainBaseCoordinator: self)

    var cancellables = Set<AnyCancellable>()
    var parentCoordinator: MainTabBarCoordinatorProtocol?


    func start() -> UIViewController {
        let homeViewController = homeCoordinator.start()
        homeCoordinator.parentCoordinator = self
        homeViewController.tabBarItem = UITabBarItem(title: "О приложении", image: UIImage(systemName: "info.circle"), tag: 0)

        let ordersViewController = ordersCoordinator.start()
        ordersCoordinator.parentCoordinator = self
        ordersViewController.tabBarItem = UITabBarItem(title: "Личный кабинет", image: UIImage(systemName: "person.circle"), tag: 1)

        let quizViewController = quizCoordinator.start()
        quizCoordinator.parentCoordinator = self
        quizViewController.tabBarItem = UITabBarItem(title: "Викторина", image: UIImage(systemName: "questionmark.circle.fill"), tag: 2)

        (rootViewController as? UITabBarController)?.viewControllers = [
            quizViewController,
            homeViewController,
            ordersViewController
        ]
        
        (rootViewController as? UITabBarController)?.selectedIndex = 0

        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .home:
            goToHomeFlow(flow)
        case .orders:
            goToOrdersFlow(flow)
        case .quiz:
            goToQuizFlow(flow)
        }
    }

    private func goToHomeFlow(_ flow: AppFlow) {
        homeCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }

    private func goToOrdersFlow(_ flow: AppFlow) {
        ordersCoordinator.moveTo(flow: flow, userData: nil)
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
    case home(HomeScreen)
    case orders(OrdersScreen)
    case quiz(QuizScreen)
}

enum HomeScreen {
    case initialScreen
    case doubleButtonScreen
}

enum OrdersScreen {
    case firstScreen
    case secondScreen
    case thirdScreen
}

enum QuizScreen {
    case firstScreen
    case secondScreen
    case thirdScreen
}
