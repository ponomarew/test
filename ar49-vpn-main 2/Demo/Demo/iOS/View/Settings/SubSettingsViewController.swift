//
//  SubSettings.swift
//  VPNClient
//
//  Created by Александр Пономарёв on 18.11.2021.
//

import UIKit
import Foundation
import TableKit

class SubSettingsViewController: UIViewController {
	@IBOutlet var tableView: UITableView! {
		didSet {
			tableDirector = TableDirector(tableView: tableView)
		}
	}
	var tableDirector: TableDirector?
	override var preferredStatusBarStyle: UIStatusBarStyle {
	  .lightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let separatorRow = TableRow<SettingsSeparatorTableViewCell>(item: "")
		
		let subStatusRow = TableRow<SubStatusRegularTableViewCell>(item: ("Subscription status", "Active"))
		var subPlan = AppSettings.subPlan
		let price = AppSettings.subPrice ?? "N/A"
		var extensionDate = AppSettings.expiryDate
		
		let dateFormatterPrint = DateFormatter()
		dateFormatterPrint.dateFormat = "dd.MM.yyyy"
		var formattedDate = dateFormatterPrint.string(from: extensionDate ?? Date())
		
		let expDateRow = TableRow<SubStatusRegularTableViewCell>(item: ("Next extension", formattedDate))
		let costStatusRow = TableRow<SubStatusRegularTableViewCell>(item: ("New period cost", price))
		
		let emptyRow = TableRow<EmptyTableViewCell>(item: "")
		
		let manageRow = TableRow<SettingsRowTableViewCell>(item: "Manage your Subscription")
			.on(.click) { [weak self] _ in
				guard let self = self else { return }
				if let url = URL(string: "itms-apps://apps.apple.com/account/subscriptions") {
					if UIApplication.shared.canOpenURL(url) {
						UIApplication.shared.open(url, options: [:])
					}
				}
				
		}
		
		let subDescRow = TableRow<SubDescTableViewCell>(item: "")
		
		
		var section = TableSection()
		section = TableSection(
			rows: [
				subStatusRow,
				separatorRow,
				expDateRow,
				separatorRow,
				costStatusRow,
				separatorRow,
				emptyRow,
				separatorRow,
				manageRow,
				separatorRow,
				subDescRow
			]
		)
		self.tableDirector ?? TableDirector(tableView: tableView) += section
	}
	
	@IBAction func backAction(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}
