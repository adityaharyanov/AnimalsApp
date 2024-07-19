//
//  ImageApiService.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 18/07/24.
//

import Foundation
import Alamofire


struct ImageApiService: ApiService {
    static let apiKey = "F0RsC7L6viQO7bzFmZTKs7hwGWhXlwm5TjAozyXUwkTmB8INisxbwjVg"
    static let baseUrl = "https://api.pexels.com/v1/"
    
    var path: String
    var method: Alamofire.HTTPMethod
    var headers: Alamofire.HTTPHeaders
    var parameters: Alamofire.Parameters?
    
    init(path: String, method: Alamofire.HTTPMethod, headers: Alamofire.HTTPHeaders, parameters: Alamofire.Parameters? = nil) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
    
    private static let authHeader = HTTPHeader(name: "Authorization", value: apiKey)
    
    static func getImages(by keyword: String, page: Int) -> ApiService {
        var params = Parameters()
        params["per_page"] = 10
        params["page"] = page

        if !keyword.isEmpty {
            params["query"] = keyword
        }

        return ImageApiService(path: baseUrl + "search/",
                        method: .get,
                        headers: .init([authHeader]),
                        parameters: params)
    }
    
    static func getNextImages(url: String) -> ApiService {


        return ImageApiService(path: url,
                        method: .get,
                        headers: .init([authHeader]))
    }
}
