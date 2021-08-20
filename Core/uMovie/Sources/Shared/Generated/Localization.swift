// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Localization {

  public enum Brand {
    /// uMovie
    public static let title = Localization.tr("Localizable", "Brand.title")
  }

  public enum Login {
    public enum ContinueOption {
      /// Continue with Apple
      public static let apple = Localization.tr("Localizable", "Login.ContinueOption.Apple")
      /// Email
      public static let email = Localization.tr("Localizable", "Login.ContinueOption.Email")
      /// Continue with Facebook
      public static let facebook = Localization.tr("Localizable", "Login.ContinueOption.Facebook")
      /// How would you like continue?
      public static let title = Localization.tr("Localizable", "Login.ContinueOption.Title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
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
