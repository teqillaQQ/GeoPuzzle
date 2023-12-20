import UIKit

protocol QuizAlertServiceLogic {
    func showAlert(message: String)
}

struct QuizAlertService: QuizAlertServiceLogic {
    func showAlert(message: String) {
        AlertHelper.showAlert(title: nil, message: message)
    }
}
