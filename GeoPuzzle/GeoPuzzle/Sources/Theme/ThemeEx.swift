import UIKit

extension Theme {
    static func makeGradientLayer(from startColor: UIColor, to endColor: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }
}
