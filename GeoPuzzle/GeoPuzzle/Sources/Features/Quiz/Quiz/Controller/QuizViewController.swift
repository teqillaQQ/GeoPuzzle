import UIKit
import SnapKit
import Combine

protocol QuizDisplayLogic: UIViewController {
    var viewModel: QuizViewModelLogic { get }
}

final class QuizViewController: UIViewController, QuizDisplayLogic {

    typealias Question = QuizModels.QuestionItem

    // MARK: - QuizDisplayLogic properties

    let viewModel: QuizViewModelLogic

    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()

    // MARK: - GUI

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let answerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

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
        self.view.addSubview(self.answerStackView)
        self.view.addSubview(self.scoreLabel)
    }

    func configureLayout() {
        self.questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        self.answerStackView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
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
                    self.updateUI(currentQuestion: model.questionItem, score: model.score)
                case .nextQuestion(let model):
                    self.updateUI(currentQuestion: model.questionItem, score: model.score)
                case .endQuiz:
                    break
                }
            }
            .store(in: &self.cancellables)
    }
}

// MARK: - Button action

private extension QuizViewController {
    func answerButtonTapped(_ senderTag: Int) {
        self.viewModel.answerButtonTapped(at: senderTag)
    }
}

// MARK: - Update UI

private extension QuizViewController {
    func updateUI(currentQuestion: Question, score: Int) {
        self.questionLabel.text = currentQuestion.question

        self.answerStackView.removeAllArrangedSubviews()

        for (index, answer) in currentQuestion.answers.enumerated() {
            let button = QuizButton()
            
            button.tag = index
            button.setText(answer)

            button.publisher(for: .touchUpInside)
                .sink { [weak self] _ in
                    self?.answerButtonTapped(button.tag)
                }
                .store(in: &self.cancellables)

            self.answerStackView.addArrangedSubview(button)
        }

        self.scoreLabel.text = "Score: \(score)"
    }
}
