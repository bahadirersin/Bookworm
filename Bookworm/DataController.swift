//
//  DataController.swift
//  Bookworm
//
//  Created by Bahadır Ersin on 16.02.2023.
//

import CoreData
import Foundation

class DataController:ObservableObject{
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
