enum QuizModels {
    enum State {
        case initial
        case displaying(DisplayModel)
        case nextQuestion(DisplayModel)
        case endQuiz
    }

    enum Event {
        case next
        case showAlert(_ isCorrectAnswer: Bool, correctAnswer: String? = nil)
        case close
    }

    struct QuestionItem {
        let question: String
        let answers: [String]
        let correctAnswerIndex: Int
    }

    struct QuestionModel {
        let questionsData: [QuestionItem]

        init(data: [QuizItem]) {
            questionsData = data.map {
                QuestionItem(
                    question: $0.question,
                    answers: $0.answers,
                    correctAnswerIndex: $0.correctAnswerIndex
                )
            }
        }
    }

    struct DisplayModel {
        let questionItem: QuestionItem
        let score: Int
    }
}
