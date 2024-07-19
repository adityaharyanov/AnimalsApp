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

    @NSManaged public var id: Int16
    @NSManaged public var width: Int16
    @NSManaged public var height: Int16
    @NSManaged public var url: String?
    @NSManaged public var avgColor: String?
    @NSManaged public var src: NSObject?

}

extension FavouriteImage : Identifiable {

}
