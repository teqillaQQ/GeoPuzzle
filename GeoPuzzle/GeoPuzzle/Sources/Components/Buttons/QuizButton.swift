import UIKit

final class QuizButton: UIButton {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
}

// MARK: - Private Methods

private extension QuizButton {
    func commonInit() {
        self.setupUI()
    }

    func setupUI() {
        setTitleColor(.white, for: .normal)
        self.applyGradientLayer()

        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Theme.Colors.primaryBlue.cgColor
        layer.masksToBounds = false

        clipsToBounds = true

        titleLabel?.font = Theme.Fonts.quizButtonFont
        titleLabel?.numberOfLines = Constants.numberOfLines
    }

    func applyGradientLayer() {
        let gradientLayer = Theme.makeGradientLayer(
            from: Theme.Colors.deepSkyBlue,
            to: Theme.Colors.darkSlateBlue
        )
        layer.insertSublayer(gradientLayer, at: Constants.layerIndex)
    }
}

// MARK: - Public Methods

extension QuizButton {
    func setText(_ text: String) {
        setTitle(text, for: .normal)
    }
}

// MARK: - Layout

extension QuizButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        if let gradientLayer = layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let cornerRadius = CGFloat(15)
    static let borderWidth = CGFloat(1)
    static let numberOfLines = 0
    static let layerIndex = UInt32(0)
}
