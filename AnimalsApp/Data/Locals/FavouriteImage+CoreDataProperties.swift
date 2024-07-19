//
//  FavouriteImage+CoreDataProperties.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//
//

import Foundation
import CoreData


extension FavouriteImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteImage> {
        return NSFetchRequest<FavouriteImage>(entityName: "FavouriteImage")
    }

    @NSManaged public var id: Int32
    @NSManaged public var width: Int32
    @NSManaged public var height: Int32
    @NSManaged public var url: String?
    @NSManaged public var avgColor: String?
    @NSManaged public var src: NSObject?
    @NSManaged public var timestamp: Date?

}

extension FavouriteImage : Identifiable {

}

extension FavouriteImage {
    convenience init(from model: Image, with context: NSManagedObjectContext) {
        self.init(context: context)
        
        id = Int32(model.id)
        width = Int32(model.width)
        height = Int32(model.height)
        url = model.url
        avgColor = model.avgColor
        src = model.src as NSObject
        timestamp = Date()
    }
}
