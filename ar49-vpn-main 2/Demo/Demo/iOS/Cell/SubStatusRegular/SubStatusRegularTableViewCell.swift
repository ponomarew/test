//
//  SubStatusRegularTableViewCell.swift
//  VPNClient
//
//  Created by Александр Пономарёв on 18.11.2021.
//

import TableKit
import UIKit

class SubStatusRegularTableViewCell: UITableViewCell, ConfigurableCell  {
	
	
	typealias CellData = (String, String)
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var descLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
	func configure(with text: (String, String)) {
		titleLabel.text = text.0
		descLabel.text = text.1
	}
}
