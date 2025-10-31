import UIKit

class Orders3ViewController: UIViewController, OrdersBaseCoordinated {

    var coordinator: OrdersCoordinatorProtocol?

    init(coordinator: OrdersCoordinatorProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Orders 3"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
    }
}
