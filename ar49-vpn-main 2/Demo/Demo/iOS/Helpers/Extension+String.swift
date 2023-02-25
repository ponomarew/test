//
//  Extension+String.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 25.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import Foundation

extension String {
	func countryName() -> String {
		if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: self) {
			return name
		} else {
			return self
		}
	}
}
