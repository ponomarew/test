//
//  StoreService.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 18.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import SwiftyUserDefaults
import SwiftyStoreKit
import Foundation

enum Products: String, CaseIterable {
	case month = "com.isoft.vpn.purchase.month"
	case halfYear = "com.isoft.vpn.purchase.sixmonth"
}

class StoreService {

	func purchase(type: Products, completion: @escaping () -> Void, errorCompletion: @escaping (String) -> Void, cancelled: @escaping () -> Void) {
		SwiftyStoreKit.purchaseProduct(type.rawValue, quantity: 1, atomically: false) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let product):
				AppSettings.isFullVersion = true
				AppSettings.isSubHasBeenBought = true
				print("Purchase Success: \(product.productId)", product.product.localizedSubscriptionPeriod)
				AppSettings.subPlan = product.productId////product.product.localizedSubscriptionPeriod
				AppSettings.subPrice = product.product.localizedPrice
				AppSettings.purchaseDate = product.originalPurchaseDate
					//AppSettings.subTimestamp = product.
//
//				switch type {
//					case .month:
//						AppSettings.subPlan = L10n.monthlyPlan
//					case .halfYear:
//						AppSettings.subPlan = "6 month"
//				}
				self.verifyReceipt {
					completion()
				} errorVerify: {
					errorCompletion("Error")
				}

			case .error(let error):
				switch error.code {
					case .paymentCancelled:
						cancelled()
					default:
						errorCompletion(error.localizedDescription)
				}
				case .deferred(purchase: _):
					print("error")
			}
		}
	}

	func restore(completion: @escaping () -> Void, error: @escaping (String) -> Void) {
		SwiftyStoreKit.restorePurchases(atomically: true) { results in
			if results.restoreFailedPurchases.count > 0 {
				print("Restore Failed: \(results.restoreFailedPurchases)")
				error("Restore Failed")
			} else if results.restoredPurchases.count > 0 {
				self.verifyReceipt {
					AppSettings.isFullVersion = true
					completion()
				} errorVerify: {
					AppSettings.isFullVersion = false
					error("Nothing to Restore")
				}
				print("Restore Success: \(results.restoredPurchases)")
			} else {
				print("Nothing to Restore")
				error("Nothing to Restore")
			}
		}
	}

	func verifyReceipt(completion: @escaping () -> Void, errorVerify: @escaping () -> Void) {
		let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "ca94201e6abb40f09fed18aa4d0b9116")
		SwiftyStoreKit.verifyReceipt(using: appleValidator, forceRefresh: false) { result in
			switch result {
			case .success(let receipt):
				let productIds = Products.allCases.map({ product in
					product.rawValue
				})
				let setProductIds = Set(productIds)
				let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: setProductIds, inReceipt: receipt)
				switch purchaseResult {
				case .purchased(let expiryDate, let items):
					AppSettings.isFullVersion = true
					AppSettings.expiryDate = expiryDate
					print("\(productIds) are valid until \(expiryDate)\n\(items)\n")
					AppSettings.subTimestamp = Int(expiryDate.timeIntervalSince1970)
					completion()

				case .expired(let expiryDate, let items):
					AppSettings.isFullVersion = false
					AppSettings.subTimestamp = nil
					print("\(productIds) are expired since \(expiryDate)\n\(items)\n")
					errorVerify()
				case .notPurchased:
					AppSettings.isFullVersion = false
					AppSettings.subTimestamp = nil
					errorVerify()
					print("The user has never purchased \(productIds)")
				}

			case .error(let error):
				print("Receipt verification failed: \(error)")
				errorVerify()
			}
		}
	}
//
//	func getMonthPrice(completion: @escaping (String) -> Void) {
//		SwiftyStoreKit.retrieveProductsInfo([Products.month.rawValue]) { [weak self] result in
//			guard let _ = self else { return }
//			if let product = result.retrievedProducts.first {
//				let priceString = product.localizedPrice ?? ""
//				completion(priceString)
//				// print("Productr: \(product.localizedDescription), price: \(priceString)")
//			} else if let invalidProductId = result.invalidProductIDs.first {
//				print("Invalidr product identifier: \(invalidProductId)")
//			} else {
//				print("Errorr: \(String(describing: result.error))")
//			}
//		}
//	}
//
//	func getHalfYearPrice(completion: @escaping (String) -> Void) {
//		SwiftyStoreKit.retrieveProductsInfo([Products.halfYear.rawValue]) { [weak self] result in
//			guard let _ = self else { return }
//			if let product = result.retrievedProducts.first {
//				let priceString = product.localizedPrice ?? ""
//				completion(priceString)
//				// print("Productr: \(product.localizedDescription), price: \(priceString)")
//			} else if let invalidProductId = result.invalidProductIDs.first {
//				print("Invalidr product identifier: \(invalidProductId)")
//			} else {
//				print("Errorr: \(String(describing: result.error))")
//			}
//		}
//	}
	
	func getPrice(completion: @escaping (String, String) -> Void) {
		SwiftyStoreKit.retrieveProductsInfo([Products.month.rawValue, Products.halfYear.rawValue]) { [weak self] result in
			guard let _ = self else { return }
			
			let month = result.retrievedProducts.filter( { $0.productIdentifier == Products.month.rawValue}).first
			let sixMonth = result.retrievedProducts.filter( { $0.productIdentifier == Products.halfYear.rawValue}).first
			
			if let product = result.retrievedProducts.first {
				// print("Productr: \(product.localizedDescription), price: \(priceString)")
			} else if let invalidProductId = result.invalidProductIDs.first {
				print("Invalidr product identifier: \(invalidProductId)")
			} else {
				print("Errorr: \(String(describing: result.error))")
			}
			
			completion(month?.localizedPrice ?? "Error", sixMonth?.localizedPrice ?? "Error")
			

		}
	}
	
}
