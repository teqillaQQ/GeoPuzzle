import UIKit

final class QuizCoordinator: Coordinator {

    // MARK: - Property

    private let modulesFactory: QuizFactoryLogic
    private let navigationService: NavigationServicesProtocol
    private let alertService: QuizAlertServiceLogic

    init(
        modulesFactory: QuizFactoryLogic = QuizModulesFactory(),
        navigationService: NavigationServicesProtocol,
        alertService: QuizAlertServiceLogic
    ) {
        self.modulesFactory = modulesFactory
        self.navigationService = navigationService
        self.alertService = alertService
    }

    // MARK: - Start coordinator

    func start(from: EntryPoint) {
        switch from {
        case .next:
            self.navigationService.pushVC(self.quizVC(), animated: true)
        }
    }
}

private extension QuizCoordinator {

    // MARK: - Quiz

    func quizVC() -> UIViewController {
        let module = self.modulesFactory.makeQuizModule()
        module.viewModel.coordinator = self
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
