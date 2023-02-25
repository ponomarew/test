//
//  AppSettings.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 18.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import SwiftyUserDefaults
import Foundation

extension DefaultsKeys {
	var isFullVersion: DefaultsKey<Bool> { .init("isFullVersion", defaultValue: false) }
	var isFirstLaunch: DefaultsKey<Bool> { .init("isFirstLaunch", defaultValue: true) }
	var isSubHasBeenBought: DefaultsKey<Bool> { .init("isSubHasBeenBought", defaultValue: false) }
	var timerOfConnection: DefaultsKey<TimeInterval?> { .init("timerOfConnection", defaultValue: 0)}
	var adBlockState: DefaultsKey<Bool> { .init("adBlockState", defaultValue: false) }
	var adBlockIsOnInSettings: DefaultsKey<Bool> { .init("adBlockIsOnInSettings", defaultValue: false) }
	var launchCount: DefaultsKey<Int> { .init("launchCount", defaultValue: 0) }

	var dateOfExit: DefaultsKey<Date?> { .init("dateOfExit", defaultValue: nil)}
	var dateOfEnter: DefaultsKey<Date?> { .init("dateOfEnter", defaultValue: nil)}
	var expiryDate: DefaultsKey<Date?> { .init("expiryDate", defaultValue: nil)}
	var hasBeenConnected: DefaultsKey<Bool> { .init("hasBeenConnected", defaultValue: false)}
	var subPlan: DefaultsKey<String?> { .init("subPlan", defaultValue: nil)}
	var purchaseDate: DefaultsKey<Date?> { .init("purchaseDate", defaultValue: nil)}
	var subPrice: DefaultsKey<String?> { .init("subPrice", defaultValue: nil)}
	var subTimestamp: DefaultsKey<Int?> { .init("subTimestamp", defaultValue: nil)}
	
	var selectedServer: DefaultsKey<String?> { .init("selectedServer", defaultValue: nil)}
	
	var freeServer: DefaultsKey<String?> { .init("freeServer", defaultValue: nil)}
	
	var configPath: DefaultsKey<URL?> { .init("configPath", defaultValue: nil)}
}

class AppSettings {
	@SwiftyUserDefault(keyPath: \.subPlan)
	static var subPlan: String?
	
	@SwiftyUserDefault(keyPath: \.subPrice)
	static var subPrice: String?

	@SwiftyUserDefault(keyPath: \.isFullVersion)
	static var isFullVersion: Bool

	@SwiftyUserDefault(keyPath: \.hasBeenConnected)
	static var hasBeenConnected: Bool

	@SwiftyUserDefault(keyPath: \.isFirstLaunch)
	static var isFirstLaunch: Bool

	@SwiftyUserDefault(keyPath: \.adBlockState)
	static var adBlockState: Bool

	@SwiftyUserDefault(keyPath: \.isSubHasBeenBought)
	static var isSubHasBeenBought: Bool

	@SwiftyUserDefault(keyPath: \.adBlockIsOnInSettings)
	static var adBlockIsOnInSettings: Bool

	@SwiftyUserDefault(keyPath: \.expiryDate)
	static var expiryDate: Date?

	@SwiftyUserDefault(keyPath: \.launchCount)
	static var launchCount: Int

	static var timerOfConnection: TimeInterval? {
		Defaults[\.timerOfConnection]
	}
	
	@SwiftyUserDefault(keyPath: \.selectedServer)
	static var selectedServer: String?
	
	@SwiftyUserDefault(keyPath: \.configPath)
	static var configPath: URL?
	
	@SwiftyUserDefault(keyPath: \.freeServer)
	static var freeServer: String?
	
	@SwiftyUserDefault(keyPath: \.purchaseDate)
	static var purchaseDate: Date?
	
	@SwiftyUserDefault(keyPath: \.subTimestamp)
	static var subTimestamp: Int?
}
