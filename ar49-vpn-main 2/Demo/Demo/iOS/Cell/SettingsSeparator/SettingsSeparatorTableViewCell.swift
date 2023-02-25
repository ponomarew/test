//
//  SettingsSeparatorTableViewCell.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 17.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import TableKit
import UIKit

class SettingsSeparatorTableViewCell: UITableViewCell, ConfigurableCell {
	func configure(with _: String) {

	}

	typealias CellData = String

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
