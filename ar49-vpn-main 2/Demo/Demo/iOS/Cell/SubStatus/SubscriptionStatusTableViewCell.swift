//
//  SubscriptionStatusTableViewCell.swift
//  HydraSDKDemo
//
//  Created by Александр Пономарёв on 17.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import TableKit
import UIKit

class SubscriptionStatusTableViewCell: UITableViewCell, ConfigurableCell {
	typealias CellData = String
	@IBOutlet var statusLabel: UILabel!
	@IBOutlet var statusImage: UIImageView!
	@IBOutlet var subStatusLabel: UILabel!
	
	enum SubStatus {
		case inactive
		case active
		
		var image: UIImage {
			switch self {
				case .inactive:
					return Asset.inactive.image
				case .active:
					return Asset.active.image
			}
		}
		
		var status: String {
			switch self {
				case .active:
					return "Active"
				case .inactive:
					return "Inactive"
			}
		}
	}
	
	func configure(with _: String) {
		if AppSettings.isFullVersion {
			subStatusLabel.text = SubStatus.active.status
			statusImage.image = SubStatus.active.image
		} else {
			subStatusLabel.text = SubStatus.inactive.status
			statusImage.image = SubStatus.inactive.image
		}
	}
    
}
