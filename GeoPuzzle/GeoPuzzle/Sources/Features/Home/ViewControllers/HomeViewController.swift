import UIKit
import SnapKit

class AboutViewController: UIViewController, AboutBaseCoordinated {
    var coordinator: AboutCoordinatorProtocol?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let appIconImageView = UIImageView()
    private let appNameLabel = UILabel()
    private let versionLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let infoStackView = UIStackView()

    init(coordinator: AboutCoordinatorProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "О приложении"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        appIconImageView.image = UIImage(systemName: "globe.europe.africa.fill")
        appIconImageView.tintColor = Theme.Colors.primaryBlue
        appIconImageView.contentMode = .scaleAspectFit
        contentView.addSubview(appIconImageView)
        
        appNameLabel.text = "GeoPuzzle"
        appNameLabel.font = .boldSystemFont(ofSize: 32)
        appNameLabel.textColor = Theme.Colors.primaryBlue
        appNameLabel.textAlignment = .center
        contentView.addSubview(appNameLabel)
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            versionLabel.text = "Версия \(version) (\(build))"
        } else {
            versionLabel.text = "Версия 1.0"
        }
        versionLabel.font = .systemFont(ofSize: 14)
        versionLabel.textColor = .secondaryLabel
        versionLabel.textAlignment = .center
        contentView.addSubview(versionLabel)
        
        descriptionLabel.text = """
        GeoPuzzle — это увлекательная викторина по географии! 
        
        Проверьте свои знания о странах, городах, реках, горах и других географических объектах нашей планеты.
        
        В викторине представлено множество вопросов различной сложности. Отвечайте правильно и улучшайте свои результаты!
        """
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        contentView.addSubview(descriptionLabel)
        
        infoStackView.axis = .vertical
        infoStackView.spacing = 20
        contentView.addSubview(infoStackView)
        
        addInfoItem(icon: "questionmark.circle.fill", title: "Вопросы", description: "Более 90 вопросов по географии")
        addInfoItem(icon: "star.fill", title: "Проверка знаний", description: "Проверьте свои географические знания")
        addInfoItem(icon: "chart.line.uptrend.xyaxis", title: "Развитие", description: "Улучшайте свои результаты")
    }
    
    private func addInfoItem(icon: String, title: String, description: String) {
        let containerView = UIView()
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 12
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = Theme.Colors.primaryBlue
        iconView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .label
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        
        containerView.addSubview(iconView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.size.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-4)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        infoStackView.addArrangedSubview(containerView)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        appIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}
