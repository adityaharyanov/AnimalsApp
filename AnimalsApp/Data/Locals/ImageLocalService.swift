//
//  ImageLocalService.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import CoreData

class ImageLocalService {
    static func save(data: Image) throws {
        var context = CoreDataService.instance.context
        var entity = FavouriteImage(context: context)
        entity.id = Int16(data.id)
        entity.height = Int16(data.height)
        entity.width = Int16(data.width)
        entity.avgColor = data.avgColor
        entity.url = data.url
        entity.src = data.src as NSObject
        
        try context.save()
    }
    
    static func fetch() throws -> [FavouriteImage] {
        var context = CoreDataService.instance.context
        var entity = FavouriteImage(context: context)
        
        var request: NSFetchRequest<FavouriteImage> = FavouriteImage.fetchRequest()
        
        let result: [FavouriteImage] = try context.fetch(request)
        
        return result;
    }
    
    static func remove(data: Image) throws {
        var context = CoreDataService.instance.context
        var entity = FavouriteImage(context: context)
        
        context.delete(entity)
    }
}
