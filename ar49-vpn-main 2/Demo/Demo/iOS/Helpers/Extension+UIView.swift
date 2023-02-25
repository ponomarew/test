//
//  Extension+UIView.swift
//  Heartio
//
//  Created by Александр Пономарёв on 17.06.2020.
//  Copyright © 2020 Александр Пономарёв. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }

    fileprivate typealias Action = (() -> Void)?

    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
					self, &AssociatedObjectKeys.tapGestureRecognizer,
					newValue,
					objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
				)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(
				self,
				&AssociatedObjectKeys.tapGestureRecognizer
			) as? Action
            return tapGestureRecognizerActionInstance
        }
    }

    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        }
    }

	 @IBInspectable
	   var borderWidth: CGFloat {
		   get {
			   layer.borderWidth
		   }
		   set {
			   layer.borderWidth = newValue
		   }
	   }

	   @IBInspectable
	   var borderColor: UIColor? {
		   get {
			   if let color = layer.borderColor {
				   return UIColor(cgColor: color)
			   }
			   return nil
		   }
		   set {
			   if let color = newValue {
				   layer.borderColor = color.cgColor
			   } else {
				   layer.borderColor = nil
			   }
		   }
	   }

    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius  }
    }

	@IBInspectable
    var shadowRadius: CGFloat {
        get {
            layer.shadowRadius
        }
        set {

            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {

        get {
            layer.shadowOffset
        }set {

            layer.shadowOffset = newValue
        }
    }

	@available(iOS 13.0, *)
	@IBInspectable
    var shadowColor: UIColor {
        get {
			UIColor.init(cgColor: layer.shadowColor ?? CGColor(gray: 0, alpha: 0))
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity: Float {

        get {
            layer.shadowOpacity
        }
        set {

            layer.shadowOpacity = newValue

        }
    }

	func rotateView(duration: Double = 1.0) {
		UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
			self.transform = self.transform.rotated(by: CGFloat(Double.pi))
		}) { [weak self] _ in
			guard let self = self else { return }
			self.rotateView(duration: duration)
		}
	}
}

@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.red
    @IBInspectable var secondColor: UIColor = UIColor.green

    @IBInspectable var vertical: Bool = true

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(red: 0.996, green: 0.667, blue: 0.537, alpha: 1).cgColor, UIColor(red: 0.996, green: 0.333, blue: 0.525, alpha: 1).cgColor]
		layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.cornerRadius = 22
        return layer
    }()

    // MARK: -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        applyGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        applyGradient()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    // MARK: -

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }

    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }

    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}

@IBDesignable
class CircularProgressBar: UIView {

let shapeLayer = CAShapeLayer()
let trackLayer = CAShapeLayer()

override init(frame: CGRect) {
super.init(frame: frame)
   // addProgressBar(radius: 50, progress: 50)
}

required init?(coder aDecoder: NSCoder) {
super.init(coder: aDecoder)
   // addProgressBar(radius: 50, progress: 50)
}
  override func layoutSubviews() {
	addProgressBar(radius: 30, progress: 3)
  }
func addProgressBar(radius: CGFloat, progress: CGFloat) {

  let lineWidth = CGFloat(1.0)// radius*0.080

	let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)

	// TrackLayer
	trackLayer.path = circularPath.cgPath
	trackLayer.fillColor = UIColor.lightGray.cgColor
	trackLayer.strokeColor = UIColor.clear.cgColor
	trackLayer.lineWidth = lineWidth
	trackLayer.lineCap = CAShapeLayerLineCap.round

	// BarLayer
	shapeLayer.path = circularPath.cgPath
	shapeLayer.fillColor = UIColor.black.cgColor
	shapeLayer.strokeColor = UIColor.systemGreen.cgColor
	shapeLayer.lineWidth = lineWidth*2
	// shapeLayer.strokeEnd = 0
	shapeLayer.lineCap = CAShapeLayerLineCap.round

	// Rotate Shape Layer
   // shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)

	// Animation
   // loadProgress(percentage: progress)

	// LoadLayers
   layer.addSublayer(trackLayer)
   self.addGradient()

  // layer.addSublayer(shapeLayer)

}

  private func addGradient() {
	let gradient = CAGradientLayer()
	gradient.colors = [UIColor.red.cgColor, UIColor.purple.cgColor, UIColor.systemPink.cgColor, UIColor.blue.cgColor]
	gradient.frame = bounds
	gradient.mask = shapeLayer
	layer.addSublayer(gradient)
  }
}
