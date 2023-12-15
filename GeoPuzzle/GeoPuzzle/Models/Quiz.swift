struct QuizItem: Codable {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}
