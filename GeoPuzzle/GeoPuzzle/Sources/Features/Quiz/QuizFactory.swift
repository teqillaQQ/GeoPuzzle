protocol QuizFactoryLogic {
    func makeQuizModule() -> QuizDisplayLogic
}

struct QuizModulesFactory: QuizFactoryLogic {
    func makeQuizModule() -> QuizDisplayLogic {
        let vm = QuizViewModel()
        return QuizViewController(vm: vm)
    }
}
