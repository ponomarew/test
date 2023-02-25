//
//  LaunchViewController.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 17.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import SwiftyGif
import SwiftyStoreKit
import Reachability
import UIKit
import OverlayContainer

class LaunchViewController: UIViewController, OverlayContainerViewControllerDelegate, UpdateServerProtocol {
	let reachability = try? Reachability()
	let storeService = StoreService()
	let containerController = OverlayContainerViewController()
	enum OverlayNotch: Int, CaseIterable {
			case minimum, maximum
	}
	override var preferredStatusBarStyle: UIStatusBarStyle {
	  .lightContent
	}
	@IBOutlet var animationView: UIImageView!
	
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
		do {
			let gif = try UIImage(gifName: "splash.gif")
			self.animationView.setGifImage(gif, loopCount: -1)
		} catch {
			print(error)
		}
		checkConnectivity { [weak self] in
			self?.reachability?.stopNotifier()
			guard let self = self else { return }
			self.storeService.verifyReceipt {
				VPNService.shared.addUser {
					self.startProgress()
				}
			} errorVerify: {
				VPNService.shared.addUser {
					self.startProgress()
				}
			}
		}
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		self.animationView = nil
	}
	
	func startProgress() {
		if AppSettings.isFirstLaunch {
			let vc = StoryboardScene.Permissions.termOfUseVc.instantiate()
			vc.modalPresentationStyle = .fullScreen
			self.present(vc, animated: true)
		} else {
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

	func checkConnectivity(completion: @escaping () -> Void) {
		reachability?.whenReachable = { [weak self] reachability in
			if reachability.connection == .wifi {
				print("Reachable via WiFi")
			} else {
				print("Reachable via Cellular")
			}
			completion()
		}
		reachability?.whenUnreachable = { [weak self] _ in
			guard let self = self else { return }
			self.showAlert(title: "Error", subtitle: "Check your internet connection")
			print("Not reachable")
		}

		do {
			try reachability?.startNotifier()
		} catch {
			print("Unable to start notifier")
		}
	}
	
	func update() {
		containerController.moveOverlay(toNotchAt: OverlayNotch.allCases.first?.rawValue ?? 78, animated: true, completion: nil)
	}
}
