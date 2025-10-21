//
//  API.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 29/08/2025.
//

import Alamofire
import Foundation

class API {
    
    public let path: String
    public let method: HTTPMethod
    public var headerParamaters: [String: String]
    public let queryParameters: [String: Any]
    public let bodyParamaters: [String: Any]
    public let bodyEncoding: ParameterEncoding
    public let fullPath: String?
    
    
    
    init(path: String,
         method: HTTPMethod = .get,
         headerParamaters:[String: String] = [:],
         queryParameters: [String: Any] = [:],
         bodyParamatersEncodable: Encodable? = nil,
         bodyParamaters: [String: Any] = [:],
         bodyEncoding: ParameterEncoding = URLEncoding.default,
         authorize: Bool = true,
         fullPath: String? = nil) {
        
        self.path = path
        self.method = method
        self.fullPath = fullPath
        let  metaHeader = [String: String]()
        
        // here we can make some checks, like if the authorize is true, I must add token to the header, and other metadata
        
        let params: NSMutableDictionary = NSMutableDictionary.init(dictionary: metaHeader)
        params["X-Master-Key"] = "$2a$10$gKGk.WhhPDqDbokEJkqkUucnE66bIZSSTGM31bo6SUkYjYbRD2Hf6"
        params.addEntries(from: headerParamaters)
        print(params)
        
        
        self.headerParamaters = params as! [String : String]
        
        
        if let encodableBody = bodyParamatersEncodable {
            if let jsonData = try? JSONEncoder().encode(encodableBody),
               let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                self.bodyParamaters = json
            } else {
                self.bodyParamaters = bodyParamaters
            }
        } else {
            self.bodyParamaters = bodyParamaters
        }
        
        self.queryParameters = queryParameters
        self.bodyEncoding = bodyEncoding
    }
}
