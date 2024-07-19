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
    func getNextImages(url: String) async throws -> ImageList
    func getFavourites() -> [Image]
    func addFavourite(data: Image) throws -> Image
    func removeFavourite(data: Image) throws -> Image
}

class ImageRepositoryImpl: ImageRepository {
    func getImages(by keyword: String, page: Int) async throws -> ImageList {
        let favourites = getFavouriteMap()
        var result = try await HttpService.get(of: ImageList.self, endpoint: ImageApiService.getImages(by: keyword, page: page))
        
        result.photos = result.photos.map({ image in
            var image = image
            image.isFavourited = favourites[image.id] != nil
            image.objectID = favourites[image.id]?.objectID
            
            return image
        })
        
        return result
    }
    
    func getNextImages(url: String) async throws -> ImageList {
        let favourites = getFavouriteMap()
        var result = try await HttpService.get(of: ImageList.self, endpoint: ImageApiService.getNextImages(url: url))
        
        result.photos = result.photos.map({ image in
            var image = image
            image.isFavourited = favourites[image.id] != nil
            image.objectID = favourites[image.id]?.objectID
            
            return image
        })
        
        return result
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
                    isFavourited: true,
                    objectID: item.objectID
                )
            }
            
            return mapped
        } catch {
            fatalError()
        }
    }
    
    private func getFavouriteMap() -> [Int: FavouriteImage] {
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
    
    func addFavourite(data: Image) throws -> Image {
        let objectID = try ImageLocalService.save(data: data)
        
        var image = data
        image.isFavourited = true
        image.objectID = objectID
        return image
        
    }
    
    func removeFavourite(data: Image) throws -> Image {
        try ImageLocalService.remove(data: data)
        
        var image = data
        image.isFavourited = false
        image.objectID = nil
        return image
    }
}
