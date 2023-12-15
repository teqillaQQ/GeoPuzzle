enum QuizModels {
    enum State {
        case initial
        case displaying(model: DisplayModel)
    }

    enum Event {
        case next
        case close
    }

    struct DisplayModel {
        struct QuestionItem {
            let question: String
            let answers: [String]
            let correctAnswerIndex: Int
        }

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
}

