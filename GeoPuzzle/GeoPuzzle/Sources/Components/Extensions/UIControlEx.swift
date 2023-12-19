import UIKit
import Combine

extension UIControl {
    final class InteractionSubscription<
        SubscriberType: Subscriber,
        Control: UIControl
    >: Subscription where SubscriberType.Input == Control {

        private var subscriber: SubscriberType?
        private let control: Control

        init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {

            self.subscriber = subscriber
            self.control = control

            self.control.addTarget(self, action: #selector(handleEvent), for: event)
        }

        @objc private func handleEvent(_ sender: UIControl) {
            _ = self.subscriber?.receive(self.control)
        }

        public func request(_ demand: Subscribers.Demand) {}

        public func cancel() {
            self.subscriber = nil
        }
    }

    struct InteractionPublisher<Control: UIControl>: Publisher {
        public typealias Output = Control
        public typealias Failure = Never

        private let control: Control
        private let events: UIControl.Event

        public init(control: Control, events: UIControl.Event) {
            self.control = control
            self.events = events
        }

        public func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Self.Failure, S.Input == Self.Output {
            let subscription = InteractionSubscription(subscriber: subscriber, control: control, event: events)

            subscriber.receive(subscription: subscription)
        }
    }

    func publisher(for events: UIControl.Event) -> UIControl.InteractionPublisher<UIControl> {
        return InteractionPublisher(control: self, events: events)
    }
}
