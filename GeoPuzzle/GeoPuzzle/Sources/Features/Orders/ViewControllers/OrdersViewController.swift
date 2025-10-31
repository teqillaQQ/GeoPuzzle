import UIKit
import SnapKit

class OrdersViewController: UIViewController, OrdersBaseCoordinated {

    var coordinator: OrdersCoordinatorProtocol?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let profileImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let statsStackView = UIStackView()
    private let sectionsStackView = UIStackView()

    init(coordinator: OrdersCoordinatorProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Личный кабинет"
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
        
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = Theme.Colors.primaryBlue
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(profileImageView)
        
        userNameLabel.text = "Географ"
        userNameLabel.font = .boldSystemFont(ofSize: 24)
        userNameLabel.textColor = .label
        userNameLabel.textAlignment = .center
        contentView.addSubview(userNameLabel)
        
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 16
        contentView.addSubview(statsStackView)
        
        addStatCard(title: "0", subtitle: "Правильных")
        addStatCard(title: "0", subtitle: "Всего ответов")
        addStatCard(title: "0%", subtitle: "Точность")
        
        sectionsStackView.axis = .vertical
        sectionsStackView.spacing = 16
        contentView.addSubview(sectionsStackView)
        
        addSectionButton(icon: "chart.bar.fill", title: "Статистика", description: "Просмотр результатов")
        addSectionButton(icon: "star.fill", title: "Достижения", description: "Заработанные награды")
        addSectionButton(icon: "gearshape.fill", title: "Настройки", description: "Параметры приложения")
    }
    
    private func addStatCard(title: String, subtitle: String) {
        let containerView = UIView()
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 12
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textColor = Theme.Colors.primaryBlue
        titleLabel.textAlignment = .center
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        statsStackView.addArrangedSubview(containerView)
    }
    
    private func addSectionButton(icon: String, title: String, description: String) {
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
        
        let chevronView = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronView.tintColor = .tertiaryLabel
        chevronView.contentMode = .scaleAspectFit
        
        containerView.addSubview(iconView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(chevronView)
        
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(12)
            make.trailing.equalTo(chevronView.snp.leading).offset(-12)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-4)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        chevronView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }
        
        sectionsStackView.addArrangedSubview(containerView)
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
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        statsStackView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        sectionsStackView.snp.makeConstraints { make in
            make.top.equalTo(statsStackView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}
