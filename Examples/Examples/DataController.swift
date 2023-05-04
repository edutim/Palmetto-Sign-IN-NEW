//
//  DataController.swift
//  Examples
//
//  Created by Chris Maggio on 3/11/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Persons")
    
    init() {
        container.loadPersistentStores {description, error in
            if let error = error {
                print("Core data failure: \(error.localizedDescription)")
            }
        }
    }
}
