//
//  VPNViewController.swift
//  VPNClient
//
//  Created by Александр Пономарёв on 27.10.2021.
//

import SwiftUI
import Alamofire
import UIKit
import NetworkExtension
import OverlayContainer

class VPNViewController: UIViewController {
	@IBOutlet var premiumButton: UIImageView!
	@IBOutlet var statusLabel: UILabel!
	@IBOutlet var indicatorImage: UIImageView!
	@IBOutlet var vpnButtonImage: UIImageView!
	@IBOutlet var settingsButton: UIView!
	
	private var isConnectedToVpn: Bool {
		if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? Dictionary<String, Any>,
			let scopes = settings["__SCOPED__"] as? [String:Any] {
			for (key, _) in scopes {
			 if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
					return true
				}
			}
		}
		return false
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
//		VPNService.shared.addUser {
//			
//		}
		
		premiumButton.addTapGestureRecognizer {
			let vc = StoryboardScene.Paywall.paywall.instantiate()
			vc.direction = .main
			vc.modalPresentationStyle = .fullScreen
			self.present(vc, animated: true)
		}
		
		settingsButton.addTapGestureRecognizer { [self] in
			let vc = StoryboardScene.Settings.settingsVC.instantiate()
			//vc.modalPresentationStyle = .fullScreen
			//self.navigationController?.pushViewController(vc, animated: true)
			self.present(vc, animated: true)
		}

		VPNService.shared.vpnPrepare()
		
		vpnButtonImage.addTapGestureRecognizer {
			if self.isConnectedToVpn {
				VPNService.shared.offVPN()
			} else {
				VPNService.shared.startVPN()
			}
		}
        
		if isConnectedToVpn {
			statusLabel.text = "VPN is connected"
			indicatorImage.image = Asset.connectedIndicator.image
			vpnButtonImage.image = Asset.connectedVPN.image
		} else {
			statusLabel.text = "VPN isn't connected"
			indicatorImage.image = Asset.turnOffIndicator.image
			vpnButtonImage.image = Asset.startVPN.image
		}
		
		let nc = NotificationCenter.default
		nc.addObserver(forName: NSNotification.Name.NEVPNStatusDidChange, object: nil , queue: nil) {
			   notification in

			   print("received NEVPNStatusDidChangeNotification")

			   let nevpnconn = notification.object as! NEVPNConnection
			   let status = nevpnconn.status
			self.checkNEStatus(status: status)
		}
	}
	
	func checkNEStatus(status: NEVPNStatus) {
		switch status {
			case .connected:
				statusLabel.text = "VPN is connected"
				indicatorImage.image = Asset.connectedIndicator.image
				vpnButtonImage.image = Asset.connectedVPN.image
				vpnButtonImage.isUserInteractionEnabled = true
				break
			case .connecting:
				vpnButtonImage.isUserInteractionEnabled = false
				statusLabel.text = "Search VPN"
				indicatorImage.image = Asset.searchIndicator.image
				vpnButtonImage.image = Asset.waitVPN.image
				break
			case .disconnecting:
				vpnButtonImage.isUserInteractionEnabled = false
				statusLabel.text = "Disconnecting"
				indicatorImage.image = Asset.searchIndicator.image
				vpnButtonImage.image = Asset.waitVPN.image
				break
			case .disconnected, .invalid:
				vpnButtonImage.isUserInteractionEnabled = true
				statusLabel.text = "VPN isn't connected"
				indicatorImage.image = Asset.turnOffIndicator.image
				vpnButtonImage.image = Asset.startVPN.image
				break
			@unknown default:
				statusLabel.text = "VPN isn't connected"
			break
	  }
	}
}

extension VPNViewController: UpdateServerProtocol {
	func update() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			VPNService.shared.startVPN()
		}
	}
}
