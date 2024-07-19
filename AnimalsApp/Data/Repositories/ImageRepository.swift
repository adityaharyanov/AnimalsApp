//
//  ImageRepository.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 18/07/24.
//

import Foundation
import RxSwift

protocol ImageRepository {
    func getImages(by keyword: String, page: Int) async throws -> ImageList

}

class ImageApiRepository: ImageRepository {

    func getImages(by keyword: String, page: Int) async throws -> ImageList {
        var result = try await HttpService.get(of: ImageList.self, endpoint: ImageApiService.getImages(by: keyword, page: page))
        return result
    }
}
