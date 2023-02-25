// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Online Privacy
  internal static let _3DaysFreeTrial = L10n.tr("Localizable", "3 Days Free Trial")
  /// Ads Free
  internal static let adsFree = L10n.tr("Localizable", "Ads Free")
  /// \nthen %@/week. Cancel anytime.
  internal static func cancelAnytime(_ p1: Any) -> String {
    return L10n.tr("Localizable", "cancel anytime", String(describing: p1))
  }
  /// change plan
  internal static let changePlan = L10n.tr("Localizable", "change plan")
  /// connecting...
  internal static let connecting = L10n.tr("Localizable", "connecting...")
  /// Continue
  internal static let `continue` = L10n.tr("Localizable", "continue")
  /// Customer Support
  internal static let customerSupport = L10n.tr("Localizable", "Customer Support")
  /// Duration
  internal static let duration = L10n.tr("Localizable", "Duration")
  /// Fast Browsing and Games
  internal static let fastBrowsingAndGames = L10n.tr("Localizable", "Fast Browsing and Games")
  /// A VPN is a private network that allows you to browse the internet anonymously and securely from anywhere in the world by creating an encrypting connection between your computer and the internet.
  internal static let firstOnboardingSubtitle = L10n.tr("Localizable", "firstOnboardingSubtitle")
  /// Over 20 Servers\nReady to connect
  internal static let firstOnboardingTitle = L10n.tr("Localizable", "firstOnboardingTitle")
  /// Free trial 3 days
  internal static let freeTrial3DaysThen = L10n.tr("Localizable", "FREE trial 3 days, then")
  /// ip address
  internal static let ipAddress = L10n.tr("Localizable", "ip address")
  /// Monthly plan
  internal static let monthlyPlan = L10n.tr("Localizable", "monthly plan")
  /// No commitment. Cancel anytime.
  internal static let noCommitmentCancelAnytime = L10n.tr("Localizable", "no commitment cancel anytime")
  /// OFF
  internal static let off = L10n.tr("Localizable", "OFF")
  /// on
  internal static let on = L10n.tr("Localizable", "on")
  /// Premium User
  internal static let premiumUser = L10n.tr("Localizable", "premium user")
  /// Privacy Policy
  internal static let privacyPolicy = L10n.tr("Localizable", "privacy policy")
  /// Rate Us
  internal static let rateUs = L10n.tr("Localizable", "Rate Us")
  /// Ready to activate?
  internal static let readyToActivate = L10n.tr("Localizable", "Ready to activate?")
  /// Restore Purchase
  internal static let restore = L10n.tr("Localizable", "restore")
  /// Your ISP can slow down binge-watching marathon. Enjoy uninterrupted streaming without buffering and bandwidth throttling while Shade VPN is on. The fast and reliable connection only.
  internal static let secondOnboardingSubtitle = L10n.tr("Localizable", "secondOnboardingSubtitle")
  /// Ultra Fast VPN servers\nwith low ping
  internal static let secondOnboardingTitle = L10n.tr("Localizable", "secondOnboardingTitle")
  /// selected server
  internal static let selectedServer = L10n.tr("Localizable", "selected server")
  /// servers
  internal static let servers = L10n.tr("Localizable", "servers")
  /// Shade Premium\nUnlock
  internal static let shadePremiumUnlock = L10n.tr("Localizable", "Shade Premium Unlock")
  /// start with free trial
  internal static let startWithFreeTrial = L10n.tr("Localizable", "start with free trial")
  /// Terms of Use
  internal static let termsOfUse = L10n.tr("Localizable", "terms of use")
  /// Encrypt all Internet traffic and protect your privacy from hackers, spies, and the government. Shade VPN mask your internet protocol address so your online actions are virtually untraceable.
  internal static let thirdOnboardingSubtitle = L10n.tr("Localizable", "thirdOnboardingSubtitle")
  /// Private Access and\nInternet Security
  internal static let thirdOnboardingTitle = L10n.tr("Localizable", "thirdOnboardingTitle")
  /// try free premium
  internal static let tryFreePremium = L10n.tr("Localizable", "try free premium")
  /// Try Premium Subscription\nfor 3 days
  internal static let tryPremiumSubscriptionFor3Days = L10n.tr("Localizable", "Try Premium Subscription for 3 days")
  /// Unlimited Bandwidth
  internal static let unlimitedBandwidth = L10n.tr("Localizable", "Unlimited Bandwidth")
  /// User
  internal static let user = L10n.tr("Localizable", "user")
  /// Weekly plan
  internal static let weeklyPlan = L10n.tr("Localizable", "weekly plan")
  /// Yearly plan
  internal static let yearlyPlan = L10n.tr("Localizable", "yearly plan")
  /// Yes, start trial
  internal static let yesStartTrial = L10n.tr("Localizable", "Yes, start trial")
  /// you are not protected
  internal static let youAreNotProtected = L10n.tr("Localizable", "you are not protected")
  /// you are protected
  internal static let youAreProtected = L10n.tr("Localizable", "you are protected")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
