protocol QuizFactoryLogic {
    func makeQuizModule(_ coordinator: QuizCoordinatorProtocol) -> QuizDisplayLogic
}

struct QuizModulesFactory: QuizFactoryLogic {
    func makeQuizModule(_ coordinator: QuizCoordinatorProtocol) -> QuizDisplayLogic {
        let vm = QuizViewModel(coordinator: coordinator)
        return QuizViewController(vm: vm)
    }
}
