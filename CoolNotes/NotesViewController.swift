//
//  NotesViewController.swift
//  CoolNotes
//
//  Created by Kevin Reese on 4/7/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

//import Foundation
import UIKit
import CoreData


class NotesViewController: CoreDataTableViewController {
    
    var notebook: Notebook?
    
    
    
    //Table View Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get the note
        let note = fetchedResultsController?.object(at: indexPath) as! Note
        
        //Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        
        //Sync note -> cell
        cell.textLabel?.text = note.text
        
        //Return cell
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let context = fetchedResultsController?.managedObjectContext, let note = fetchedResultsController?.object(at: indexPath) as? Note, editingStyle == .delete {
            context.delete(note)
        }
    }
    
    
    @IBAction func addNewNote(_ sender: Any) {
        
        //Create a new Note
        
        if let nb = notebook, let context = fetchedResultsController?.managedObjectContext {
            //Just create a new note and you're done
            let note = Note(text: "New Note", context: context)
            note.creationDate = Date()
            note.notebook = nb
            
           //print(note)
            //print(nb)
            
        }
    }
}
    
    

