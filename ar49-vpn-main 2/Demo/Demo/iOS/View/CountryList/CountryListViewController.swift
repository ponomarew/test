//
//  CountryListViewController.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 17.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import TableKit
import UIKit

protocol UpdateServerProtocol {
	func update()
}

class CountryListViewController: UIViewController {
	@IBOutlet var serversLabel: UILabel!
	@IBOutlet var tableView: UITableView! {
        didSet {
			self.tableView.keyboardDismissMode = .onDrag
            tableDirector = TableDirector(tableView: tableView)
        }
    }
	override var preferredStatusBarStyle: UIStatusBarStyle {
	  .lightContent
	}
	var tableDirector: TableDirector?
	var serverList: [Server]?
	var delegate: UpdateServerProtocol?
	var heightDelegate: UpdateServerProtocol?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.showSpinner()
		
		if #available(iOS 11.0, *) {
			view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		}
		view.layer.cornerRadius = 10
		
		populateTable()
    }
	
	func getStatus(id: String) -> Bool {
		if AppSettings.freeServer == id {
			return true
		} else {
			return false
		}
	}

	func populateTable() {
		tableDirector?.clear()
		

        let countrySection = TableSection(rows: nil)
		VPNService.shared.getServers { servers in
			self.serverList = servers.servers
			self.serverList?.forEach({ server in
				var isSelected = false
				if AppSettings.selectedServer == server.id {
					isSelected = true
				}
				countrySection += TableRow<CountryTableViewCell>(item: Country(name: server.name ?? "noname", isSelected: isSelected, isPremium: self.getStatus(id: server.id ?? "false")))
					.on(.custom(MyActions.SearchClicked), handler: { row in
						if AppSettings.isFullVersion {
							self.showSpinner()
							VPNService.shared.changeServer(id: server.id ?? "", completion: {
								row.cell?.isSelected = true
								self.populateTable()
								self.removeSpinner()
								self.heightDelegate?.update()
								self.delegate?.update()
							})
							
						} else {
							self.goToPaywall()
						}
					})
			})
			self.tableDirector ?? TableDirector(tableView: self.tableView) += countrySection
			self.tableDirector?.reload()
			self.removeSpinner()
		}
	}
	
	

	func goToPaywall() {
		let vc = StoryboardScene.Paywall.paywall.instantiate()
		vc.modalPresentationStyle = .fullScreen
		vc.direction = .main
		self.present(vc, animated: true)
	}
}
