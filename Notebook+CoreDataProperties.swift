//
//  Notebook+CoreDataProperties.swift
//  CoolNotes
//
//  Created by Kevin Reese on 4/6/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import CoreData


extension Notebook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notebook> {
        return NSFetchRequest<Notebook>(entityName: "Notebook")
    }

    @NSManaged var creationDate: Date?
    @NSManaged var name: String?
    @NSManaged var notes: NSSet? //[Note]?

}
