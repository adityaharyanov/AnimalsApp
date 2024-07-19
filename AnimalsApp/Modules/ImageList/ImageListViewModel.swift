//
//  ImageListViewModel.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import RxCocoa
import RxSwift

final class ImageListViewModel {
    
    private let repository: ImageRepository
    let disposeBag = DisposeBag()
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    var keyword: String?
    var page: Int = 1
    var nextPageUrl: String = ""
    
    var images = BehaviorRelay<[Image]>(value: [])
    
    /// When `data` is `nil` then it will fetch from local favourite
    /// If `data` not `nil` it will fetch from API with corresponding keyword
    init(data: String? = nil, repository: ImageRepository) {
        self.keyword = data
        self.repository = repository
    }
    
    func load() {
        Task.init { [weak self] in
            guard let self = self else { return }
            do {
                self.isLoading.accept(true)
                let result: ImageList
                
                if let keyword = self.keyword {
                    result = try await self.fetchImages(by: keyword, page: self.page)
                } else {
                    result = self.fetchFavourites()
                }
                
                self.page = result.page
                self.nextPageUrl = result.nextPageUrl
                self.images.accept(result.photos)
            } catch {
                print(error.localizedDescription)
            }
            
            if self.isLoading.value {
                self.isLoading.accept(false)
            }
        }
    }
    
    func fetchImages(by keyword: String, page: Int) async throws -> ImageList {
        let result = try await repository.getImages(by: keyword, page: page)
        
        return result;
    }
    
    func fetchFavourites() -> ImageList {
        let result = repository.getFavourites()
        
        return ImageList(
            totalResults: result.count,
            page: 1,
            perPage: result.count,
            photos: result, nextPageUrl: ""
        );
    }
    
    func fetchNextPageImages() {
        
        Task.init { [weak self] in
            guard let self = self else { return }
            do {
                let result = try await self.repository.getNextImages(url: nextPageUrl)
                self.page = result.page
                self.nextPageUrl = result.nextPageUrl
                self.images.acceptAppending(result.photos)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func toggleFavourite(at index: Int) -> Bool {
        var list = images.value;
        var item = list[index]
        
        do {
            if let isFavourited = item.isFavourited {
                if (isFavourited) {
                    item = try repository.removeFavourite(data: item)
                } else {
                    item = try repository.addFavourite(data: item)
                }
            }
        
            list[index] = item
            
            images.accept(list)
            
            return item.isFavourited!
            
        } catch {
            fatalError()
        }
    }
}
