//
//  CombineApiClient.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 29/08/2025.
//

import Foundation
import Alamofire
import Combine

class CombineApiClient {
    
    public static let shared: CombineApiClient = CombineApiClient()
    public static let baseUrl = Config.environment.baseURL
    
    func request<T: Decodable>(_ type: T.Type, endPoint: API) -> AnyPublisher<T, ErrorResponse> {
        print(endPoint)
        var urlString: String
        if let fullPath = endPoint.fullPath, !fullPath.isEmpty {
            urlString = fullPath
        } else if !endPoint.path.isEmpty {
            urlString = CombineApiClient.baseUrl + endPoint.path
        } else {
            return Fail(error: ErrorResponse(message: .localizedInvalidUrl, code: 400))
                .eraseToAnyPublisher()
        }
        
        guard let url = URL(string: urlString) else {
            return Fail(error: ErrorResponse(message: .localizedInvalidUrl, code: 400))
                .eraseToAnyPublisher()
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if !endPoint.queryParameters.isEmpty {
            urlComponents?.queryItems = endPoint.queryParameters.map {
                URLQueryItem(name: "\($0)", value: "\($1)")
            }
        }
        
        guard let finalURL = urlComponents?.url else {
            return Fail(error: ErrorResponse(message: .localizedInvalidUrl, code: 400))
                .eraseToAnyPublisher()
        }
        
        return AF.request(finalURL,
                          method: endPoint.method,
                          parameters: endPoint.bodyParamaters,
                          encoding: endPoint.bodyEncoding,
                          headers: HTTPHeaders(endPoint.headerParamaters))
        .validate()
        .responseString { response in
            let statusCode = response.response?.statusCode
            print(finalURL)
            print("Status code: \(statusCode ?? -1)")
            switch response.result {
            case .success(let value):
//                let decoded = try? JSONDecoder().decode(T.self, from: value.data(using: .utf8)!)
//                print(decoded ?? "nil")
                print("Response: \(value)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        .publishDecodable(type: T.self)
        .value()
        .mapError { afError in
            if let code = afError.responseCode {
                return ErrorResponse(message: afError.localizedDescription, code: code)
            } else if !(NetworkReachabilityManager()?.isReachable ?? true) {
                return ErrorResponse(message: .localizedNoInternetConnection, code: 0)
            } else {
                return ErrorResponse(message: .localizedAnErrorOccurredWhenConnectToServerMessage, code: 0)
            }
        }
        .eraseToAnyPublisher()
    }
}
