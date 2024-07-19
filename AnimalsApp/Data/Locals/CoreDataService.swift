//
//  CoreDataService.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import CoreData

class CoreDataService: ObservableObject {
    static let instance: CoreDataService = CoreDataService()
    
    private let container = NSPersistentContainer(name: "AnimalsApp")
    var context: NSManagedObjectContext {
        get {
            return container.viewContext
        }
    }
    
    init() {
        container.loadPersistentStores { description, err in
            if let err = err {
                fatalError(err.localizedDescription)
            }
        }
    }
}
