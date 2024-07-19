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
    func addFavourite(data: Image)
    func removeFavourite(data: Image)
}

class ImageApiRepository: ImageRepository {
    func addFavourite(data: Image) {
        do {
            try ImageLocalService.save(data: data)
        } catch {
            fatalError()
        }
    }
    
    func getFavourites() -> [Image] {
        do {
            let result = try ImageLocalService.fetch()
            
            let mapped = result.map { item in
                Image(
                    id: Int(item.id),
                    width: Int(item.width),
                    height: Int(item.height),
                    url: item.url ?? "",
                    avgColor: item.avgColor ?? "",
                    src: item.src as? [String:String] ?? [:],
                    isFavourited: true)
            }
            
            return mapped
        } catch {
            fatalError()
        }
    }
    
    func getFavouriteMap() -> [Int: FavouriteImage] {
        do {
            let result = try ImageLocalService.fetch()
            
            let mapped: [Int: FavouriteImage] = result.reduce(into: [:]) { partialResult, value in
                partialResult[Int(value.id)] = value
            }
            
            return mapped
        } catch {
            fatalError()
        }
    }
    
    func removeFavourite(data: Image) {
        do {
            try ImageLocalService.remove(data: data)
        } catch {
            fatalError()
        }
    }
    
    func getImages(by keyword: String, page: Int) async throws -> ImageList {
        var favourites = getFavouriteMap()
        var result = try await HttpService.get(of: ImageList.self, endpoint: ImageApiService.getImages(by: keyword, page: page))
        
        result.photos = result.photos.map({ image in
            var image = image
            image.isFavourited = favourites[image.id] != nil
            
            return image
        })
        
        return result
    }
}
