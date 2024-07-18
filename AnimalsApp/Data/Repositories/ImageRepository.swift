//
//  ImageRepository.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 18/07/24.
//

import Foundation
import RxSwift

protocol ImageRepository {
    func getImages(by keyword: String, page: Int) -> Observable<ImageList>
}

class ImageApiRepository: ImageRepository {
    func getImages(by keyword: String, page: Int) -> Observable<ImageList> {
        return HttpService.get(of: ImageList.self, endpoint: ImageApiService.getImages(by: keyword, page: page))
            .do(onNext: { print($0.photos.first?.url ?? "No Data") })
    }
}
