import Combine

class Coordinator: CoordinatorProtocol {
    var cancellables: Set<AnyCancellable> = []
}
