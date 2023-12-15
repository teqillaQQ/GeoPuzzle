import Combine

protocol CoordinatorProtocol: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
}
