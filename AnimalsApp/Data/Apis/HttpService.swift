//
//  ApiService.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation
import Alamofire


protocol ApiService {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var headers: HTTPHeaders { get set }
    var parameters: Parameters? { get set }
}

class HttpService {
    static func get<T : Codable>(of type : T.Type, endpoint: ApiService) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: URLEncoding.default, headers: endpoint.headers)
                .validate()
                .responseDecodable(of: type) { (response) in
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            print("Data: \(utf8Text)")
                        }
                    switch response.result {
                    case .success(let result):
                        continuation.resume(returning: result)
                        
                    case .failure(let error):
                        switch response.response?.statusCode {
                        case 403:
                            continuation.resume(throwing: ApiError.forbidden)
                        case 404:
                            continuation.resume(throwing: ApiError.notFound)
                        case 409:
                            continuation.resume(throwing: ApiError.conflict)
                        case 500:
                            continuation.resume(throwing: ApiError.internalServerError)
                        default:
                            continuation.resume(throwing: error)
                        }
                    }
                }
        }
    }
}

enum ApiError: Error {
    case forbidden              // Status code 403
    case notFound               // Status code 404
    case conflict               // Status code 409
    case internalServerError    // Status code 500
}
