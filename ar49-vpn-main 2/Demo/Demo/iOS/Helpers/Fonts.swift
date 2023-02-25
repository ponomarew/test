// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Montserrat {
    internal static let black = FontConvertible(name: "Montserrat-Black", family: "Montserrat", path: "Montserrat-Black.ttf")
    internal static let blackItalic = FontConvertible(name: "Montserrat-BlackItalic", family: "Montserrat", path: "Montserrat-BlackItalic.ttf")
    internal static let bold = FontConvertible(name: "Montserrat-Bold", family: "Montserrat", path: "Montserrat-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "Montserrat-BoldItalic", family: "Montserrat", path: "Montserrat-BoldItalic.ttf")
    internal static let extraBold = FontConvertible(name: "Montserrat-ExtraBold", family: "Montserrat", path: "Montserrat-ExtraBold.ttf")
    internal static let extraBoldItalic = FontConvertible(name: "Montserrat-ExtraBoldItalic", family: "Montserrat", path: "Montserrat-ExtraBoldItalic.ttf")
    internal static let extraLight = FontConvertible(name: "Montserrat-ExtraLight", family: "Montserrat", path: "Montserrat-ExtraLight.ttf")
    internal static let extraLightItalic = FontConvertible(name: "Montserrat-ExtraLightItalic", family: "Montserrat", path: "Montserrat-ExtraLightItalic.ttf")
    internal static let italic = FontConvertible(name: "Montserrat-Italic", family: "Montserrat", path: "Montserrat-Italic.ttf")
    internal static let light = FontConvertible(name: "Montserrat-Light", family: "Montserrat", path: "Montserrat-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "Montserrat-LightItalic", family: "Montserrat", path: "Montserrat-LightItalic.ttf")
    internal static let medium = FontConvertible(name: "Montserrat-Medium", family: "Montserrat", path: "Montserrat-Medium.ttf")
    internal static let mediumItalic = FontConvertible(name: "Montserrat-MediumItalic", family: "Montserrat", path: "Montserrat-MediumItalic.ttf")
    internal static let regular = FontConvertible(name: "Montserrat-Regular", family: "Montserrat", path: "Montserrat-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "Montserrat-SemiBold", family: "Montserrat", path: "Montserrat-SemiBold.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "Montserrat-SemiBoldItalic", family: "Montserrat", path: "Montserrat-SemiBoldItalic.ttf")
    internal static let thin = FontConvertible(name: "Montserrat-Thin", family: "Montserrat", path: "Montserrat-Thin.ttf")
    internal static let thinItalic = FontConvertible(name: "Montserrat-ThinItalic", family: "Montserrat", path: "Montserrat-ThinItalic.ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  internal enum MuseoModerno {
    internal static let black = FontConvertible(name: "MuseoModerno-Black", family: "MuseoModerno", path: "MuseoModerno-Black.ttf")
    internal static let bold = FontConvertible(name: "MuseoModerno-Bold", family: "MuseoModerno", path: "MuseoModerno-Bold.ttf")
    internal static let extraBold = FontConvertible(name: "MuseoModerno-ExtraBold", family: "MuseoModerno", path: "MuseoModerno-ExtraBold.ttf")
    internal static let extraLight = FontConvertible(name: "MuseoModerno-ExtraLight", family: "MuseoModerno", path: "MuseoModerno-ExtraLight.ttf")
    internal static let light = FontConvertible(name: "MuseoModerno-Light", family: "MuseoModerno", path: "MuseoModerno-Light.ttf")
    internal static let medium = FontConvertible(name: "MuseoModerno-Medium", family: "MuseoModerno", path: "MuseoModerno-Medium.ttf")
    internal static let regular = FontConvertible(name: "MuseoModerno-Regular", family: "MuseoModerno", path: "MuseoModerno-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "MuseoModerno-SemiBold", family: "MuseoModerno", path: "MuseoModerno-SemiBold.ttf")
    internal static let thin = FontConvertible(name: "MuseoModerno-Thin", family: "MuseoModerno", path: "MuseoModerno-Thin.ttf")
    internal static let all: [FontConvertible] = [black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin]
  }
  internal enum Raleway {
    internal static let black = FontConvertible(name: "Raleway-Black", family: "Raleway", path: "Raleway-Black.ttf")
    internal static let blackItalic = FontConvertible(name: "Raleway-BlackItalic", family: "Raleway", path: "Raleway-BlackItalic.ttf")
    internal static let bold = FontConvertible(name: "Raleway-Bold", family: "Raleway", path: "Raleway-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "Raleway-BoldItalic", family: "Raleway", path: "Raleway-BoldItalic.ttf")
    internal static let extraBold = FontConvertible(name: "Raleway-ExtraBold", family: "Raleway", path: "Raleway-ExtraBold.ttf")
    internal static let extraBoldItalic = FontConvertible(name: "Raleway-ExtraBoldItalic", family: "Raleway", path: "Raleway-ExtraBoldItalic.ttf")
    internal static let extraLight = FontConvertible(name: "Raleway-ExtraLight", family: "Raleway", path: "Raleway-ExtraLight.ttf")
    internal static let extraLightItalic = FontConvertible(name: "Raleway-ExtraLightItalic", family: "Raleway", path: "Raleway-ExtraLightItalic.ttf")
    internal static let italic = FontConvertible(name: "Raleway-Italic", family: "Raleway", path: "Raleway-Italic.ttf")
    internal static let light = FontConvertible(name: "Raleway-Light", family: "Raleway", path: "Raleway-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "Raleway-LightItalic", family: "Raleway", path: "Raleway-LightItalic.ttf")
    internal static let medium = FontConvertible(name: "Raleway-Medium", family: "Raleway", path: "Raleway-Medium.ttf")
    internal static let mediumItalic = FontConvertible(name: "Raleway-MediumItalic", family: "Raleway", path: "Raleway-MediumItalic.ttf")
    internal static let regular = FontConvertible(name: "Raleway-Regular", family: "Raleway", path: "Raleway-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "Raleway-SemiBold", family: "Raleway", path: "Raleway-SemiBold.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "Raleway-SemiBoldItalic", family: "Raleway", path: "Raleway-SemiBoldItalic.ttf")
    internal static let thin = FontConvertible(name: "Raleway-Thin", family: "Raleway", path: "Raleway-Thin.ttf")
    internal static let thinItalic = FontConvertible(name: "Raleway-ThinItalic", family: "Raleway", path: "Raleway-ThinItalic.ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [Montserrat.all, MuseoModerno.all, Raleway.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = BundleToken.bundle
    return bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
