//
//  AnimalApiService.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation
import Alamofire


struct AnimalApiService: ApiService {
    static let apiKey = "pfFQJxLiPMYqvY5rZXbYdw==VBjYVanTRFZdEhx9"
    let baseUrl = "https://api.api-ninjas.com/v1/"
    
    var path: String
    var method: Alamofire.HTTPMethod
    var headers: Alamofire.HTTPHeaders
    var parameters: Alamofire.Parameters?
    
    init(path: String, method: Alamofire.HTTPMethod, headers: Alamofire.HTTPHeaders, parameters: Alamofire.Parameters? = nil) {
        self.path = baseUrl + path
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
    
    private static let authHeader = HTTPHeader(name: "X-Api-Key", value: apiKey)
    
    static func getAnimals(by keyword: String) -> ApiService {
        var params = Parameters()

        if !keyword.isEmpty {
            params["name"] = keyword
        }

        return AnimalApiService(path: "animals/",
                        method: .get,
                        headers: .init([authHeader]),
                        parameters: params)
    }
}
