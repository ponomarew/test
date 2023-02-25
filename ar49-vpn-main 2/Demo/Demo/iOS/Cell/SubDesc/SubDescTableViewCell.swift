//
//  SubDescTableViewCell.swift
//  VPNClient
//
//  Created by Александр Пономарёв on 18.11.2021.
//

import TableKit
import UIKit

class SubDescTableViewCell: UITableViewCell, ConfigurableCell {
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
