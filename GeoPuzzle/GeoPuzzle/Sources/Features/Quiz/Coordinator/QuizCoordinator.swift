import UIKit
import Combine

final class QuizCoordinator: QuizCoordinatorProtocol {

    // MARK: - QuizCoordinatorProtocol property

    var parentCoordinator: MainTabBarCoordinatorProtocol?
    var cancellables = Set<AnyCancellable>()

    lazy var rootViewController: UIViewController = UINavigationController()

    // MARK: - Private property

    private let modulesFactory: QuizFactoryLogic
    private let alertService: QuizAlertServiceLogic

    init(
        modulesFactory: QuizFactoryLogic = QuizModulesFactory(),
        alertService: QuizAlertServiceLogic = QuizAlertService()
    ) {
        self.modulesFactory = modulesFactory
        self.alertService = alertService
    }

    func start() -> UIViewController {
        self.rootViewController = UINavigationController(rootViewController: self.quizVC())
        return self.rootViewController
    }

    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .quiz(let screen):
            handleQuizFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }

    private func handleQuizFlow(for screen: QuizScreen, userData: [String : Any]? = nil) {
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

//    // MARK: - Start coordinator
//
//    func start(from: EntryPoint) {
//        switch from {
//        case .next:
//            self.navigationService.pushVC(self.quizVC(), animated: true)
//        }
//    }
}

private extension QuizCoordinator {

    // MARK: - Quiz

    func quizVC() -> UIViewController {
        let module = self.modulesFactory.makeQuizModule(self)
        module.viewModel.event
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .next:
                    break
                case .close:
                    self.navigationService.popVC()
                case .showAlert(let isCorrectAnswer, let correctAnswer):
                    self.alertService.showAlert(isCorrectAnswer: isCorrectAnswer, correctAnswer: correctAnswer)
                }
            }
            .store(in: &self.cancellables)
        return module
    }
}

extension QuizCoordinator {
    enum EntryPoint {
        case next
    }
}


//import UIKit
//
//final class QuizCoordinator: Coordinator {
//
//    // MARK: - Property
//
//    private let modulesFactory: QuizFactoryLogic
//    private let navigationService: NavigationServicesProtocol
//    private let alertService: QuizAlertServiceLogic
//
//    init(
//        modulesFactory: QuizFactoryLogic = QuizModulesFactory(),
//        navigationService: NavigationServicesProtocol,
//        alertService: QuizAlertServiceLogic
//    ) {
//        self.modulesFactory = modulesFactory
//        self.navigationService = navigationService
//        self.alertService = alertService
//    }
//
//    // MARK: - Start coordinator
//
//    func start(from: EntryPoint) {
//        switch from {
//        case .next:
//            self.navigationService.pushVC(self.quizVC(), animated: true)
//        }
//    }
//}
//
//private extension QuizCoordinator {
//
//    // MARK: - Quiz
//
//    func quizVC() -> UIViewController {
//        let module = self.modulesFactory.makeQuizModule()
//        module.viewModel.coordinator = self
//        module.viewModel.event
//            .sink { [weak self] event in
//                guard let self else { return }
//                switch event {
//                case .next:
//                    break
//                case .close:
//                    self.navigationService.popVC()
//                case .showAlert(let isCorrectAnswer, let correctAnswer):
//                    self.alertService.showAlert(isCorrectAnswer: isCorrectAnswer, correctAnswer: correctAnswer)
//                }
//            }
//            .store(in: &self.cancellables)
//        return module
//    }
//}
//
//extension QuizCoordinator {
//    enum EntryPoint {
//        case next
//    }
//}
