// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Localization {

  public enum Alert {
    /// Oops! =(
    public static let ops = Localization.tr("Localizable", "Alert.Ops")
    public enum EmptyField {
      /// Please, fill all fields to continue.
      public static let message = Localization.tr("Localizable", "Alert.EmptyField.Message")
    }
  }

  public enum Brand {
    /// uMovie
    public static let title = Localization.tr("Localizable", "Brand.title")
  }

  public enum General {
    /// Continue
    public static let `continue` = Localization.tr("Localizable", "General.Continue")
    /// Create account
    public static let createAccount = Localization.tr("Localizable", "General.CreateAccount")
    /// Email
    public static let email = Localization.tr("Localizable", "General.Email")
    /// Got it!
    public static let gotIt = Localization.tr("Localizable", "General.GotIt")
    /// Ok!
    public static let okay = Localization.tr("Localizable", "General.Okay")
    /// Password
    public static let password = Localization.tr("Localizable", "General.Password")
  }

  public enum Login {
    public enum EmailAuthentication {
      /// Forgot my password
      public static let forgotMyPasswordTitle = Localization.tr("Localizable", "Login.EmailAuthentication.ForgotMyPasswordTitle")
      /// What is your email and password?
      public static let title = Localization.tr("Localizable", "Login.EmailAuthentication.Title")
    }
    public enum Options {
      /// Continue with Apple
      public static let apple = Localization.tr("Localizable", "Login.Options.Apple")
      /// Continue with Facebook
      public static let facebook = Localization.tr("Localizable", "Login.Options.Facebook")
      /// How would you like to continue?
      public static let title = Localization.tr("Localizable", "Login.Options.Title")
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
