import Foundation
import Combine

protocol QuizViewModelLogic: AnyObject {
    var coordinator: Coordinator? { get set }
    var state: AnyPublisher<QuizModels.State, Never> { get }
    var event: AnyPublisher<QuizModels.Event, Never> { get }

    func prepareForDisplaying()
    func answerButtonTapped(at answerIndex: Int)
}

final class QuizViewModel: QuizViewModelLogic {

    typealias QuestionModel = QuizModels.QuestionModel
    typealias Question = QuizModels.QuestionItem

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

    private var questions: [Question]?
    private var currentQuestionIndex = 0
    private var score = 0

    // MARK: - Actions

    func prepareForDisplaying() {
        self.requestQuizData()
    }

    func answerButtonTapped(at answerIndex: Int)  {
        guard let currentQuestion = self.questions?.get(by: self.currentQuestionIndex) else { return }

        if answerIndex == currentQuestion.correctAnswerIndex {
            self.eventSubject.send(.showAlert(true))
            self.score += 1
        } else {
            let correctAnswer = currentQuestion.answers[currentQuestion.correctAnswerIndex]
            self.eventSubject.send(.showAlert(false, correctAnswer: correctAnswer))
        }

        self.currentQuestionIndex += 1

        guard let nextQuestion = self.questions?.get(by: self.currentQuestionIndex)
        else {
            self.stateSubject.send(.endQuiz)
            return
        }
        self.stateSubject.send(.nextQuestion(
            .init(
                questionItem: nextQuestion,
                score: self.score
            )
        ))
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
            let questionModel = QuestionModel(data: quizItems)

            self.questions = questionModel.questionsData

            guard let currentQuestion = self.questions?.get(by: self.currentQuestionIndex) else { return }
            self.stateSubject.send(.displaying(
                .init(
                    questionItem: currentQuestion,
                    score: self.score
                )
            ))
        } catch {
            self.eventSubject.send(.close)
        }
    }
}
