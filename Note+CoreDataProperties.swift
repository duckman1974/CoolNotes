//
//  Note+CoreDataProperties.swift
//  CoolNotes
//
//  Created by Kevin Reese on 4/6/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import CoreData


extension Note {

   // @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
    //    return NSFetchRequest<Note>(entityName: "Note")
   // }

    @NSManaged var creationDate: Date?
    @NSManaged var text: String?
    @NSManaged var notebook: NSManagedObject      //Notebook?

}
