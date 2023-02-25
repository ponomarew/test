//
//  CountryTableViewCell.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 16.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import TableKit
import UIKit

struct Country {
	var name = String()
	var isSelected: Bool
	var isPremium: Bool
}

class CountryTableViewCell: UITableViewCell, ConfigurableCell {
	typealias CellData = Country
	@IBOutlet var flagImage: UIImageView!
	@IBOutlet var countryName: UILabel!
	@IBOutlet var checkImage: UIImageView!
	@IBOutlet var latencyImage: UIImageView!
	@IBOutlet var bgView: UIView!
	@IBOutlet var freeServerImage: UIImageView!
	@IBOutlet var premiumImage: UIImageView!
	var latencyImages: [UIImage] = [Asset.fullLatency.image, Asset.upMidLatency.image]
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.contentView.addTapGestureRecognizer { [weak self] in
			guard let self = self else { return }
			TableCellAction(key: MyActions.SearchClicked, sender: self).invoke()
		}
    }
	
	override func prepareForReuse() {
		bgView.backgroundColor = .clear
	}

	func configure(with country: Country) {
		latencyImage.image = latencyImages.randomElement()
		countryName.text = country.name
		if AppSettings.isFullVersion {
			freeServerImage.isHidden = true
			premiumImage.isHidden = true
		}
		if !country.isPremium {
			freeServerImage.isHidden = true
			premiumImage.isHidden = false
		} else {
			freeServerImage.isHidden = false
			premiumImage.isHidden = true
		}
		if country.isSelected {
			bgView.backgroundColor = #colorLiteral(red: 0.2459767163, green: 0.3278463483, blue: 0.3818917871, alpha: 1)
		} else {
			bgView.backgroundColor = .clear
		}
	}
}
