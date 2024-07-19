//
//  ImageLocalService.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import CoreData

class ImageLocalService {
    private static let context = CoreDataService.instance.context
    static func save(data: Image) throws -> NSManagedObjectID {
        let entity = FavouriteImage(from: data, with: context)
        
        try context.save()
        
        return entity.objectID
    }
    
    static func fetch() throws -> [FavouriteImage] {
        let request = FavouriteImage.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:"timestamp", ascending:false)]
        
        let result: [FavouriteImage] = try context.fetch(request)
        
        return result;
    }
    
    static func remove(data: Image) throws {
        
        if let objectID = data.objectID as? NSManagedObjectID {
            let entity = try context.existingObject(with: objectID)
            context.delete(entity)
        }
        
    }
}
