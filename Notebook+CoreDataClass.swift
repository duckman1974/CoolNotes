//
//  Notebook+CoreDataClass.swift
//  CoolNotes
//
//  Created by Kevin Reese on 4/6/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import CoreData

//@objc(Notebook)
class Notebook: NSManagedObject {
    
    convenience init(name: String, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Notebook", in: context) {
            self.init(entity: ent, insertInto: context)
            self.name = name
            self.creationDate = Date()
            
            
        } else {
            fatalError("Unable to find Entity name!")
        }
        
        var humanReadable : String {
            
            get{
                let fmt = DateFormatter()
                fmt.timeStyle = .none
                fmt.dateStyle = .short
                fmt.doesRelativeDateFormatting = true
                fmt.locale = NSLocale.current
                
                return fmt.string(from: creationDate!)
            }
        }
    }
}
