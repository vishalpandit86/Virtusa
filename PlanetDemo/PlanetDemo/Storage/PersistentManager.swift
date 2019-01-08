//
//  PersistentManager.swift
//  PlanetDemo
//
//  Created by Tripathi, Himani on 1/8/19.
//  Copyright © 2019 Tripathi, Himani. All rights reserved.
//

import Foundation
import CoreData

final class PersistentManager {
    private init() {}
    static let shared = PersistentManager()
    
    lazy var context = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlanetDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
