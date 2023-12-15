import UIKit
import SnapKit
import Combine

protocol QuizDisplayLogic {
    var viewModel: QuizViewModelLogic { get }
}

final class QuizViewController: UIViewController, QuizDisplayLogic {

    typealias QuizData = QuizModels.DisplayModel.QuestionItem

    // MARK: - QuizDisplayLogic properties

    let viewModel: QuizViewModelLogic

    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()
    private var quizData = [QuizData]()
    private var currentQuestionIndex = 0
    private var score = 0

    // MARK: - GUI

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private var answerButtons = [UIButton]()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    // MARK: - Initialization

    init(vm: QuizViewModelLogic) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        self.binding()
        self.viewModel.prepareForDisplaying()
    }
}

private extension QuizViewController {
    func configureView() {
        self.configureViewProperties()
        self.configureSubviews()
        self.configureLayout()
    }

    func configureViewProperties() {
        self.view.backgroundColor = .white
    }

    func configureSubviews() {
        self.view.addSubview(self.questionLabel)
        self.view.addSubview(self.scoreLabel)
    }

    func configureLayout() {
        self.questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        for index in 0..<4 {
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.titleLabel?.numberOfLines = 0
            button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
            self.view.addSubview(button)

            button.snp.makeConstraints { make in
                make.top.equalTo(questionLabel.snp.bottom).offset(20 + CGFloat(index * 50))
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(40)
            }

            self.answerButtons.append(button)
        }

        self.scoreLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Binding

private extension QuizViewController {
    func binding() {
        self.bindInput()
    }

    func bindInput() {
        self.viewModel.state
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .initial:
                    break
                case .displaying(let model):
                    self.quizData = model.questionsData
                    self.updateUI()
                }
            }
            .store(in: &self.cancellables)
    }
}

// MARK: - Button action

private extension QuizViewController {
    @objc private func answerButtonTapped(_ sender: UIButton) {
        let selectedAnswerIndex = self.answerButtons.firstIndex(of: sender) ?? -1

        guard self.currentQuestionIndex < self.quizData.count else {
            return
        }

        let currentQuizItem = self.quizData[self.currentQuestionIndex]

        guard selectedAnswerIndex >= 0, selectedAnswerIndex < currentQuizItem.answers.count else {
            return
        }

        if selectedAnswerIndex == currentQuizItem.correctAnswerIndex {
            self.showAlert(message: "Правильный ответ!")
            self.score += 1
        } else {
            self.showAlert(message: "Неправильный ответ.")
        }

        self.currentQuestionIndex += 1

        if self.currentQuestionIndex < quizData.count {
            self.updateUI()
        } else {

        }
    }
}

// MARK: - Alert

private extension QuizViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Update UI

private extension QuizViewController {
    func updateUI() {
        guard self.currentQuestionIndex < self.quizData.count else {
            return
        }

        let currentQuizItem = self.quizData[self.currentQuestionIndex]
        self.questionLabel.text = currentQuizItem.question

        for (index, button) in self.answerButtons.enumerated() {
            if index < currentQuizItem.answers.count {
                button.setTitle(currentQuizItem.answers[index], for: .normal)
            } else {
                button.setTitle("", for: .normal)
            }
        }

        self.scoreLabel.text = "Score: \(score)"
    }
}
