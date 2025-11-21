//
//  Configration.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 29/08/2025.
//

import Foundation

class Config {
    static let environment: AppEnvironment = .live
    
    public static let apiKey: String = {
        guard let apiKey = Bundle.main.infoDictionary?["MOVIE_API_KEY"] as? String else {
            fatalError("Set an API_KEY value in BaseConfig.xcconfig or check the README")
        }
        return apiKey
    }()

    public static let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public static let bundleID = "com.fespinozacast.youtube.MovieCatalog"

    public static let deepLinkScheme: String = "moviecat"
}
