import Foundation
import Combine

protocol QuizViewModelLogic: AnyObject {
    var coordinator: Coordinator? { get set }
    var state: AnyPublisher<QuizModels.State, Never> { get }
    var event: AnyPublisher<QuizModels.Event, Never> { get }

    func prepareForDisplaying()
}

final class QuizViewModel: QuizViewModelLogic {

    // MARK: - QuizViewModelLogic properties

    var coordinator: Coordinator?
    
    var state: AnyPublisher<QuizModels.State, Never> {
        self.stateSubject.eraseToAnyPublisher()
    }

    var event: AnyPublisher<QuizModels.Event, Never> {
        self.eventSubject.eraseToAnyPublisher()
    }

    // MARK: - Private properties

    private let stateSubject = CurrentValueSubject<QuizModels.State, Never>(.initial)
    private let eventSubject = PassthroughSubject<QuizModels.Event, Never>()

    // MARK: - Actions

    func prepareForDisplaying() {
        self.requestQuizData()
    }
}

// MARK: - Request quiz data

private extension QuizViewModel {
    func requestQuizData() {
        guard let url = Bundle.main.url(forResource: "quizData", withExtension: "json") else {
            print("Error: Couldn't find quizData.json in the bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let quizItems = try JSONDecoder().decode([QuizItem].self, from: data)

            self.stateSubject.send(.displaying(model: .init(data: quizItems)))
        } catch {
            self.eventSubject.send(.close)
        }
    }
}
