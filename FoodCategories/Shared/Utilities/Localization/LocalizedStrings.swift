//
//  LocalizedStrings.swift
//  TestOf2P
//
//  Created by Majd Aldeyn Ez Alrejal on 30/08/2025.
//



extension LocalizedStrings {
    enum Keys: String {
        case invalidUrl
        case noInternetConnection
        case anErrorOccurredWhenConnectToServerMessage
        case accessDenied
        case parsingError
        case loading
        case retry
        case reload
        case noDataFound
    }
}

class LocalizedStrings {
    
    static var shared: LocalizedStrings = LocalizedStrings()
    private var stringsDic: [Keys: String]
    
    init() {
        switch Defaults.AppDefaults.appLanguage {
        case .arabic:
            self.stringsDic = LocalizedStrings.localizedArabicStrings()
        case .english:
            self.stringsDic = LocalizedStrings.localizedEnglishStrings()
        }
    }
    
    func string(forKey key: Keys) -> String {
        return self.stringsDic[key] ?? key.rawValue
    }
    
    static private func localizedEnglishStrings() -> [Keys: String] {
        [
            .invalidUrl: "Invalid URL",
            .noInternetConnection: "No internet connection",
            .anErrorOccurredWhenConnectToServerMessage: "An error occurred when connect to server",
            .accessDenied: "Access Denied",
            .parsingError: "Parse Error",
            .loading: "Loading",
            .retry: "Retry",
            .reload: "Reload",
            .noDataFound: "No Data Found",
        ]
    }
    
    static private func localizedArabicStrings() -> [Keys: String] {
        [
            .invalidUrl: "رابط غير صالح",
            .noInternetConnection: "لا يوجد اتصال بالإنترنت",
            .anErrorOccurredWhenConnectToServerMessage: "حدث خطأ ما أثناء الاتصال بالسيرفر",
            .accessDenied: "لم يتم السماح لك",
            .parsingError: "خطأ في التحليل",
            .loading: "جاري التحميل",
            .retry: "أعد المحاولة",
            .reload: "أعد التحميل",
            .noDataFound: "لم يتم العثور على بيانات",
        ]
    }
}

