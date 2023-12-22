import UIKit

protocol QuizAlertServiceLogic {
    func showAlert(isCorrectAnswer: Bool, correctAnswer: String?)
}

struct QuizAlertService: QuizAlertServiceLogic {
    func showAlert(isCorrectAnswer: Bool, correctAnswer: String?) {
        let title = isCorrectAnswer ? "Правильный ответ!" : "Неправильный ответ!"
        let message = isCorrectAnswer ? nil : "Правильный ответ \(correctAnswer ?? "")"

        AlertHelper.showAlert(
            title: title,
            message: message,
            buttonTitle: "Ок"
        )
    }
}

