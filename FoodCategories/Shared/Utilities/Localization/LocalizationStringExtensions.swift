//
//  LocalizationStringExtensions.swift
//  TestOf2P
//
//  Created by Majd Aldeyn Ez Alrejal on 30/08/2025.
//

extension String {
    public static let localizedInvalidUrl: String = LocalizedStrings.shared.string(forKey: .invalidUrl)
    public static let localizedNoInternetConnection: String = LocalizedStrings.shared.string(forKey: .noInternetConnection)
    public static let localizedAnErrorOccurredWhenConnectToServerMessage: String = LocalizedStrings.shared.string(forKey: .anErrorOccurredWhenConnectToServerMessage)
    public static let localizedAccessDenied: String = LocalizedStrings.shared.string(forKey: .accessDenied)
    public static let localizedParsingError: String = LocalizedStrings.shared.string(forKey: .parsingError)
    public static let localizedLoading: String = LocalizedStrings.shared.string(forKey: .loading)
    public static let localizedRetry: String = LocalizedStrings.shared.string(forKey: .retry)
    public static let localizedReload: String = LocalizedStrings.shared.string(forKey: .reload)
    public static let localizedNoDataFound: String = LocalizedStrings.shared.string(forKey: .reload)
}
