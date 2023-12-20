import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        get {
            return (0..<count).contains(index) ? self[index] : nil
        }
        set {
            if let element = newValue, (0..<count).contains(index) {
                self[index] = element
            }
        }
    }

    func get(by index: Int) -> Element? {
        self[safe: index]
    }
}
