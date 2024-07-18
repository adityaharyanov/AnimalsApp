//
//  ApiService.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation
import Alamofire
import RxSwift


protocol ApiService {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var headers: HTTPHeaders { get set }
    var parameters: Parameters? { get set }
}

class HttpService {
    static func get<T : Codable>(of type : T.Type, endpoint: ApiService) -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            AF.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: URLEncoding.default, headers: endpoint.headers)
                .validate()
                .responseDecodable(of: type) { (response) in
                    switch response.result {
                    case .success(let result):
                        observer.onNext(result)
                        observer.onCompleted()
                        
                    case .failure(let error):
                            switch response.response?.statusCode {
                            case 403:
                                observer.onError(ApiError.forbidden)
                            case 404:
                                observer.onError(ApiError.notFound)
                            case 409:
                                observer.onError(ApiError.conflict)
                            case 500:
                                observer.onError(ApiError.internalServerError)
                            default:
                                observer.onError(error)
                            }
                    }
                }
                return Disposables.create()
        }
    }
}

enum ApiError: Error {
    case forbidden              // Status code 403
    case notFound               // Status code 404
    case conflict               // Status code 409
    case internalServerError    // Status code 500
}
