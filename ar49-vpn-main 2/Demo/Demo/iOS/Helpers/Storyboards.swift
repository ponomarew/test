// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length implicit_return

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum CountryList: StoryboardType {
    internal static let storyboardName = "CountryList"

    internal static let initialScene = InitialSceneType<CountryListViewController>(storyboard: CountryList.self)

    internal static let countryList = SceneType<CountryListViewController>(storyboard: CountryList.self, identifier: "countryList")
  }
	
	internal enum Permissions: StoryboardType {
	  internal static let storyboardName = "Permissions"

	  internal static let termOfUseVc = SceneType<TermsOfUseViewController>(storyboard: Permissions.self, identifier: "termOfUseVc")
	}
	
	
  internal enum Launch: StoryboardType {
    internal static let storyboardName = "Launch"

    internal static let initialScene = InitialSceneType<LaunchViewController>(storyboard: Launch.self)

    internal static let launch = SceneType<LaunchViewController>(storyboard: Launch.self, identifier: "launch")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

//    internal static let main = SceneType<MainViewController>(storyboard: Main.self, identifier: "main")
//
    internal static let mainNC = SceneType<UIKit.UINavigationController>(storyboard: Main.self, identifier: "mainNC")
  }
	
	internal enum Paywall: StoryboardType {
	  internal static let storyboardName = "Paywall"

	  internal static let initialScene = InitialSceneType<PaywallViewController>(storyboard: Paywall.self)

	  internal static let paywall = SceneType<PaywallViewController>(storyboard: Paywall.self, identifier: "paywall")
	}
	
	internal enum Settings: StoryboardType {
	  internal static let storyboardName = "Settings"

	  internal static let initialScene = InitialSceneType<SettingsViewController>(storyboard: Settings.self)

	  internal static let settingsVC = SceneType<SettingsViewController>(storyboard: Settings.self, identifier: "settingsVC")
		
	  internal static let subSettingsVC = SceneType<SubSettingsViewController>(storyboard: Settings.self, identifier: "subSettingsVC")
	}
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController(creator: block) else {
      fatalError("Storyboard \(storyboard.storyboardName) does not have an initial scene.")
    }
    return controller
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
