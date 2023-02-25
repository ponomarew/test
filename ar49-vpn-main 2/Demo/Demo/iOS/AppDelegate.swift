//
//  AppDelegate.swift
//  Demo
//
//  Created by Davide De Rosa on 2/11/17.
//  Copyright (c) 2021 Davide De Rosa. All rights reserved.
//
//  https://github.com/keeshux
//
//  This file is part of TunnelKit.
//
//  TunnelKit is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  TunnelKit is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with TunnelKit.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit
import NetworkExtension
import SwiftyBeaver
import SwiftyStoreKit

private let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
			for purchase in purchases {
				switch purchase.transaction.transactionState {
					case .purchased, .restored:
						if purchase.needsFinishTransaction {
						// Deliver content from server, then:
						SwiftyStoreKit.finishTransaction(purchase.transaction)
						}
					// Unlock content
					case .failed, .purchasing, .deferred:
						break // do nothing
				}
			}
		}

        return true
    }
}
