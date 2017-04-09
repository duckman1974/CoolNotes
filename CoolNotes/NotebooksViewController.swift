//
//  NotebooksViewController.swift
//  CoolNotes
//
//  Created by Kevin Reese on 4/7/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

//import Foundation
import UIKit
import CoreData

class NotebooksViewController: CoreDataTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the title
        
        title = "CoolNotes"
        
        //Get the Stack
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        //Create the fetch request
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true), NSSortDescriptor(key: "creationDate", ascending: false)]
        
        //Create a fetched ResultsController
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        
    }
    
    @IBAction func addNewNoteBook(_ sender: AnyObject) {
        //Create a new Notebook
        let nb = Notebook(name: "New Notebook", context: fetchedResultsController!.managedObjectContext)
        print("Just created a new Notebook: \(nb)")
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Find the notebook
        let nb = fetchedResultsController!.object(at: indexPath) as! Notebook
        
        //Create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotebookCell", for: indexPath)
        
        //Sync notebook -> cell
        cell.textLabel?.text = nb.name
        cell.detailTextLabel?.text = String(format: "%d notes", nb.notes!.count)
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "displayNote" {
            
            if let notesVC = segue.destination as? NotesViewController {
                
                // Create Fetch Request
                let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                
                fr.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false),NSSortDescriptor(key: "text", ascending: true)]
                
                // So far we have a search that will match ALL notes. However, we're
                // only interested in those within the current notebook:
                // NSPredicate to the rescue!
                let indexPath = tableView.indexPathForSelectedRow!
                let notebook = fetchedResultsController?.object(at: indexPath)
                
                let pred = NSPredicate(format: "notebook = %@", argumentArray: [notebook!])
                
                fr.predicate = pred
                
                // Create FetchedResultsController
                let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (fetchedResultsController!.managedObjectContext), sectionNameKeyPath: nil, cacheName: nil)
      
                
                // Inject it into the notesVC
                notesVC.fetchedResultsController = fc

            }
        }
    }
}
