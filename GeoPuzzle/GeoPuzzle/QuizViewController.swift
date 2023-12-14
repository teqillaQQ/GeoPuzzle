import UIKit
import SnapKit

class QuizViewController: UIViewController {

    var quizData: [QuizItem] = []
    var currentQuestionIndex = 0

    // UI
    let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    var answerButtons: [UIButton] = []

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizData()
        setupUI()
        updateUI()
    }

    // MARK: - Load quiz data from JSON

    func loadQuizData() {
        guard let path = Bundle.main.path(forResource: "quizData", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let quizItems = try? JSONDecoder().decode([QuizItem].self, from: data) else {
            return
        }
        quizData = quizItems
    }

    // MARK: - UI setup and update methods

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        for index in 0..<4 {
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.titleLabel?.numberOfLines = 0
            button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
            view.addSubview(button)

            button.snp.makeConstraints { make in
                make.top.equalTo(questionLabel.snp.bottom).offset(20 + CGFloat(index * 50))
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(40)
            }

            answerButtons.append(button)
        }
    }

    func updateUI() {
        guard currentQuestionIndex < quizData.count else {

            return
        }

        let currentQuizItem = quizData[currentQuestionIndex]
        questionLabel.text = currentQuizItem.question

        for (index, button) in answerButtons.enumerated() {
            button.setTitle(currentQuizItem.answers[index], for: .normal)
        }
    }

    // MARK: - Button action

    @objc func answerButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1

        if currentQuestionIndex < quizData.count {
            updateUI()
        } else {

        }
    }
}

struct QuizItem: Codable {
    let question: String
    let answers: [String]
}
