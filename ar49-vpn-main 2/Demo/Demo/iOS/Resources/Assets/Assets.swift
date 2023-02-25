// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let backgroundColor = ColorAsset(name: "backgroundColor")
  internal static let backgroundSecond = ColorAsset(name: "backgroundSecond")
  internal static let bgForPaywall = ColorAsset(name: "bgForPaywall")
  internal static let blue = ColorAsset(name: "blue")
  internal static let defaultTextColor = ColorAsset(name: "defaultTextColor")
  internal static let grey = ColorAsset(name: "grey")
  internal static let violet = ColorAsset(name: "violet")
  internal static let connectedIndicator = ImageAsset(name: "connectedIndicator")
  internal static let vector = ImageAsset(name: "Vector")
  internal static let active = ImageAsset(name: "active")
  internal static let arrowBack = ImageAsset(name: "arrowBack")
  internal static let autoserver = ImageAsset(name: "autoserver")
  internal static let backgroundForVpnButton = ImageAsset(name: "backgroundForVpnButton")
  internal static let bg = ImageAsset(name: "bg")
  internal static let bgpaywall = ImageAsset(name: "bgpaywall")
  internal static let connectedVPN = ImageAsset(name: "connectedVPN")
  internal static let crown = ImageAsset(name: "crown")
  internal static let disclosureArrow = ImageAsset(name: "disclosureArrow")
  internal static let dot = ImageAsset(name: "dot")
  internal static let dragIndicator = ImageAsset(name: "dragIndicator")
  internal static let freeserver = ImageAsset(name: "freeserver")
  internal static let fullLatency = ImageAsset(name: "fullLatency")
  internal static let grayBackArrow = ImageAsset(name: "grayBackArrow")
  internal static let grayDisclosure = ImageAsset(name: "grayDisclosure")
  internal static let greyCross = ImageAsset(name: "greyCross")
  internal static let inactive = ImageAsset(name: "inactive")
  internal static let info = ImageAsset(name: "info")
  internal static let launch = ImageAsset(name: "launch")
  internal static let mediumLatency = ImageAsset(name: "mediumLatency")
  internal static let paywallcross = ImageAsset(name: "paywallcross")
  internal static let premium = ImageAsset(name: "premium")
  internal static let premiumButton = ImageAsset(name: "premiumButton")
  internal static let searchIndicator = ImageAsset(name: "searchIndicator")
  internal static let settings = ImageAsset(name: "settings")
  internal static let shield = ImageAsset(name: "shield")
  internal static let sort = ImageAsset(name: "sort")
  internal static let startVPN = ImageAsset(name: "startVPN")
  internal static let turnOffIndicator = ImageAsset(name: "turnOffIndicator")
  internal static let upMidLatency = ImageAsset(name: "upMidLatency")
  internal static let waitVPN = ImageAsset(name: "waitVPN")
  internal static let whiteCross = ImageAsset(name: "whiteCross")
  internal static let whiteDisclosure = ImageAsset(name: "whiteDisclosure")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = Color(asset: self)

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
