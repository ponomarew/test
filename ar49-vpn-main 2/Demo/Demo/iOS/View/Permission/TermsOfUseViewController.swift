//
//  TermsOfUseViewController.swift
//  HydraSDKDemo
//
//  Created by Александр Пономарёв on 05.11.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import OverlayContainer
import SwiftRichString
import UIKit

class TermsOfUseViewController: UIViewController, OverlayContainerViewControllerDelegate, UpdateServerProtocol {
	func update() {
		containerController.moveOverlay(toNotchAt: OverlayNotch.allCases.first?.rawValue ?? 78, animated: true, completion: nil)
	}
	
	@IBOutlet var termsOfUseLabel: UILabel!
	@IBOutlet var acceptButton: UIButton!
	let containerController = OverlayContainerViewController()
	enum OverlayNotch: Int, CaseIterable {
			case minimum, maximum
	}
	
	private func notchHeight(for notch: OverlayNotch, availableSpace: CGFloat) -> CGFloat {
		switch notch {
			case .maximum:
				return availableSpace * 0.85
			case .minimum:
				return 90
		}
	}
	
	func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
		let notch = OverlayNotch.allCases[index]
		return notchHeight(for: notch, availableSpace: availableSpace)
	}
	
	func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
		OverlayNotch.allCases.count
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
	//	acceptButton.setTitle(L10n.acceptAndContinue, for: .normal)
		let regular = Style {
			$0.font = FontFamily.Montserrat.regular.font(size: 15)
		}
		let bold = Style {
			$0.font = FontFamily.Montserrat.bold.font(size: 15)
		}
//		let termsOfUseAttributedString = AttributedString.composing {
//			"\(L10n.yourPrivacyIsOurPriority)".set(style: bold)
//			"\(L10n.iAmVPNCollects)\n".set(style: regular)
//			"\(L10n.weDoNotKeepLogs)".set(style: bold)
//			"\(L10n.forMoreInformationPleaseReadOurPrivacyPolicy)".set(style: regular)
//		}
//		termsOfUseLabel.attributedText = termsOfUseAttributedString
    }
    
	@IBAction func acceptPrivacy(_ sender: Any) {
		AppSettings.isFirstLaunch = false
//		let vc = StoryboardScene.Main.mainNC.instantiate()
//		vc.modalPresentationStyle = .fullScreen
//		self.present(vc, animated: true)
		let mainNavVC = StoryboardScene.Main.mainNC.instantiate()
		let countryVC = StoryboardScene.CountryList.countryList.instantiate()
		countryVC.delegate = mainNavVC.viewControllers.first as? VPNViewController
		countryVC.heightDelegate = self

		containerController.modalPresentationStyle = .custom
		containerController.delegate = self
		containerController.viewControllers = [
			mainNavVC,
			countryVC
		]
		present(containerController, animated: true)
	}
}
