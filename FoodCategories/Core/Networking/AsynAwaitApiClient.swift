//
//  AsynAwaitApiClient.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 20/09/2025.
//

import Foundation
import Alamofire

class AsynAwaitApiClient {
    public static let shared = AsynAwaitApiClient()
    public static let baseUrl = Config.environment.baseURL

    func request<T: Decodable>(_ type: T.Type, endPoint: API) async throws -> T {
        var urlString: String
        if let fullPath = endPoint.fullPath, !fullPath.isEmpty {
            urlString = fullPath
        } else if !endPoint.path.isEmpty {
            urlString = AsynAwaitApiClient.baseUrl + endPoint.path
        } else {
            throw ErrorResponse(message: .localizedInvalidUrl, code: 400)
        }

        guard let url = URL(string: urlString) else {
            throw ErrorResponse(message: .localizedInvalidUrl, code: 400)
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if !endPoint.queryParameters.isEmpty {
            urlComponents?.queryItems = endPoint.queryParameters.map {
                URLQueryItem(name: "\($0)", value: "\($1)")
            }
        }

        guard let finalURL = urlComponents?.url else {
            throw ErrorResponse(message: .localizedInvalidUrl, code: 400)
        }

        let dataTask = AF.request(finalURL,
                                  method: endPoint.method,
                                  parameters: endPoint.bodyParamaters,
                                  encoding: endPoint.bodyEncoding,
                                  headers: HTTPHeaders(endPoint.headerParamaters))
            .validate()
            .serializingDecodable(T.self)

        do {
            let value = try await dataTask.value
            return value
        } catch let afError as AFError {
            if let code = afError.responseCode {
                throw ErrorResponse(message: afError.localizedDescription, code: code)
            } else if !(NetworkReachabilityManager()?.isReachable ?? true) {
                throw ErrorResponse(message: .localizedNoInternetConnection, code: 0)
            } else {
                throw ErrorResponse(message: .localizedAnErrorOccurredWhenConnectToServerMessage, code: 0)
            }
        }
    }
}
