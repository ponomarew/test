//
//  PaywallViewController.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 17.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import SwiftyStoreKit
import SwiftRichString
import UIKit

public extension UIView {

	@discardableResult
	public func addBlur(style: UIBlurEffect.Style = .light) -> UIVisualEffectView {
		let blurEffect = UIBlurEffect(style: style)
		let blurBackground = UIVisualEffectView(effect: blurEffect)
		blurBackground.alpha = 0.5
		blurBackground.layer.cornerRadius = 15
		blurBackground.layer.masksToBounds = true
		insertSubview(blurBackground, at: 0)
	//	addSubview(blurBackground)
		blurBackground.translatesAutoresizingMaskIntoConstraints = false
		blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
		blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		return blurBackground
	}
	
	func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
			layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
			 
			let gradientLayer = CAGradientLayer()
		gradientLayer.cornerRadius = 15
			gradientLayer.colors = colorArray.map({ $0.cgColor })
			if isVertical {
				//top to bottom
				gradientLayer.locations = [0.0, 1.0]
			} else {
				//left to right
				gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
				gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
			}
			
			backgroundColor = .clear
			gradientLayer.frame = bounds
			layer.insertSublayer(gradientLayer, at: 0)
		}
}

protocol PaywallViewDelegate: AnyObject {
	func update()
}

class PaywallViewController: UIViewController {
//	@IBOutlet var infoLabel: UILabel!
	weak var delegate: PaywallViewDelegate?
	var update: (() -> Void)?

//	@IBOutlet var termsOfUseLabel: UILabel!
//
//	@IBOutlet var freetrialLabel: UILabel!
	let storeService = StoreService()
	@IBOutlet var noadsLabel: UILabel!
	@IBOutlet var empireVpnLabel: UILabel!
//
//	@IBOutlet var oneYearLabel: UILabel!
//	@IBOutlet var oneMonthLabel: UILabel!
//	@IBOutlet var oneWeekLabel: UILabel!
//
//	@IBOutlet var pricePerWeek: UILabel!
//	@IBOutlet var monthPerMonth: UILabel!
//	@IBOutlet var pricePerYear: UILabel!

	@IBOutlet var noSpeedLabel: UILabel!
	@IBOutlet var privateLabel: UILabel!
	@IBOutlet var fastConnection: UILabel!
	
	//@IBOutlet var purchaseView: UIView!
	@IBOutlet var privacyLabel: UILabel!
	@IBOutlet var restoreButton: UIButton!
//	@IBOutlet var animationView: AnimationView!
	@IBOutlet var monthBGView: UIView!
	@IBOutlet var sixMonthBGView: UIView!
	@IBOutlet var monthPriceLabel: UILabel!
	@IBOutlet var halfYearPriceLabel: UILabel!
	
	enum FromWhere {
		case onboarding
		case settings
		case main
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
	  .lightContent
	}
	@IBOutlet var scrollView: UIScrollView!
	
	@IBOutlet var threeDayTrialMonthView: UIView!
	@IBOutlet var threeDayTrialView: UIView!
	var direction: FromWhere = .onboarding

	override func viewDidLoad() {
        super.viewDidLoad()

		threeDayTrialView.applyGradient(isVertical: true, colorArray: [#colorLiteral(red: 0.1607843137, green: 0.7294117647, blue: 0.3568627451, alpha: 1), #colorLiteral(red: 0.09411764706, green: 0.6078431373, blue: 0.3411764706, alpha: 1)])
		
		threeDayTrialMonthView.applyGradient(isVertical: true, colorArray: [#colorLiteral(red: 0.1607843137, green: 0.7294117647, blue: 0.3568627451, alpha: 1), #colorLiteral(red: 0.09411764706, green: 0.6078431373, blue: 0.3411764706, alpha: 1)])
		
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = view.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		monthBGView.addBlur()
		sixMonthBGView.addBlur()

		self.showSpinner()
		storeService.getPrice { month, halfyear in
			self.monthPriceLabel.text = month
			self.halfYearPriceLabel.text = halfyear
			self.removeSpinner()
		}
		
		sixMonthBGView.addTapGestureRecognizer {
			self.showSpinner()
			self.storeService.purchase(type: .halfYear) {
				self.removeSpinner()
				self.dismiss(animated: true, completion: nil)
			} errorCompletion: { error in
				self.removeSpinner()
			} cancelled: {
				self.removeSpinner()
			}
		}
		
		monthBGView.addTapGestureRecognizer {
			self.showSpinner()
			self.storeService.purchase(type: .month) {
				self.removeSpinner()
				self.dismiss(animated: true, completion: nil)
			} errorCompletion: { error in
				self.removeSpinner()
			} cancelled: {
				self.removeSpinner()
			}

		}

		noadsLabel.text = L10n._3DaysFreeTrial
		fastConnection.text = L10n.fastBrowsingAndGames
		privateLabel.text = L10n.unlimitedBandwidth
		noSpeedLabel.text = L10n.adsFree

		restoreButton.setTitle(L10n.restore, for: .normal)
		
		noadsLabel.font = FontFamily.Montserrat.medium.font(size: 15)
		privateLabel.font = FontFamily.Montserrat.medium.font(size: 15)
		noSpeedLabel.font = FontFamily.Montserrat.medium.font(size: 15)
		fastConnection.font = FontFamily.Montserrat.medium.font(size: 15)
    }

	@IBAction func restoreAction(_ sender: Any) {
		self.showSpinner()
		storeService.restore(completion: { [weak self] in
			guard let self = self else { return }
			self.removeSpinner()
			self.delegate?.update()
			self.update?()
			switch self.direction {
				case .main:
					self.dismiss(animated: true, completion: nil)
			//		self.navigationController?.popViewController(animated: true)
				case .onboarding:
					self.dismiss(animated: true, completion: nil)
//					let vc = StoryboardScene.Main.mainNC.instantiate()
//					vc.modalPresentationStyle = .fullScreen
//					self.present(vc, animated: true)
				case .settings:
					self.dismiss(animated: true, completion: nil)
					//self.navigationController?.popViewController(animated: true)
					// self.dismiss(animated: true, completion: nil)
			}
		}, error: { [weak self] string in
			guard let self = self else { return }
			self.removeSpinner()
			self.showAlert(title: "Info", subtitle: string)
		})
	}

	@IBAction func closeAction(_ sender: Any) {
		switch direction {
			case .onboarding:
				let vc = StoryboardScene.Main.mainNC.instantiate()
				vc.modalPresentationStyle = .fullScreen
				self.present(vc, animated: true)
			case .settings:
				self.navigationController?.popViewController(animated: true)
				// self.dismiss(animated: true, completion: nil)
			case .main:
				self.dismiss(animated: true, completion: nil)
		}
		self.update?()
	}

}
