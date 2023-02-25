//
//  Extension+UIViewController.swift
//  EmpireVPN
//
//  Created by Александр Пономарёв on 19.09.2020.
//  Copyright © 2020 Anchorfree Inc. All rights reserved.
//

import UIKit
import Foundation

private var aView: UIView?

extension UIViewController {

	func showSpinner() {
		aView = UIView(frame: self.view.bounds)
		aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

		let ai = UIActivityIndicatorView(style: .whiteLarge)
		ai.center = aView?.center ?? CGPoint(x: 0, y: 0)
		ai.startAnimating()
		aView?.addSubview(ai)
		self.view.addSubview(aView ?? UIView())
	}

	func removeSpinner() {
		aView?.removeFromSuperview()
		aView = nil
	}

	func showAlert(title: String, subtitle: String) {
		let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
		self.present(alert, animated: true)
	}
}
