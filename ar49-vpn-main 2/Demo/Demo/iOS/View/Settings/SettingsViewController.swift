//
//  SettingsViewController.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 17.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import MessageUI
import TableKit
import UIKit

class SettingsViewController: UIViewController {
	@IBOutlet var tableView: UITableView! {
        didSet {
            tableDirector = TableDirector(tableView: tableView)
        }
    }
	var tableDirector: TableDirector?
	override var preferredStatusBarStyle: UIStatusBarStyle {
	  .lightContent
	}
	@IBOutlet var navigationTitle: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		

    }
	
	override func viewWillAppear(_ animated: Bool) {
		populateTable()
	}
	
	func populateTable() {
		tableDirector?.clear()
		let separatorRow = TableRow<SettingsSeparatorTableViewCell>(item: "")
		
		let subStatusRow = TableRow<SubscriptionStatusTableViewCell>(item: "")
			.on(.click) { _ in
				if AppSettings.isFullVersion {
					let vc = StoryboardScene.Settings.subSettingsVC.instantiate()
					self.present(vc, animated: true)
				} else {
					let vc = StoryboardScene.Paywall.paywall.instantiate()
					vc.modalPresentationStyle = .fullScreen
					vc.direction = .main
					self.present(vc, animated: true)
				}
			}
		
		let privacyRow = TableRow<SettingsRowTableViewCell>(item: "Privacy Policy")
			.on(.click) { [weak self] _ in
				guard let self = self else { return }
				
		}
		let termsOfUseRow = TableRow<SettingsRowTableViewCell>(item: "Terms of Use")
			.on(.click) { [weak self] _ in
				guard let self = self else { return }
				
		}
		
		
		var section = TableSection()
		section = TableSection(
			rows: [
				subStatusRow,
				separatorRow,
				privacyRow,
				separatorRow,
				termsOfUseRow,
				separatorRow
			]
		)
		self.tableDirector ?? TableDirector(tableView: tableView) += section
	}

	@IBAction func closeAction(_ sender: Any) {
		//self.navigationController?.popToRootViewController(animated: true)
		self.dismiss(animated: true, completion: nil)
	}

//	func open(with url: URL) {
//		if UIApplication.shared.canOpenURL(url) {
//			if #available(iOS 10.0, *) {
//				UIApplication.shared.open(url, options: [:], completionHandler: nil)
//			} else {
//				UIApplication.shared.openURL(url)
//			}
//		}
//	}
}
