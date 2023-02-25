//
//  SettingsRowTableViewCell.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 17.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import TableKit
import UIKit

class SettingsRowTableViewCell: UITableViewCell, ConfigurableCell {
	func configure(with text: String) {
		titleLabel.text = text
	}

	typealias CellData = String

	@IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
