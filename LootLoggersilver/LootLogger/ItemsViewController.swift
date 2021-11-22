//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by rasha  on 10/04/1443 AH.
//

import Foundation
import  UIKit
class ItemsViewController: UITableViewController {
    
  
        var itemStore: ItemStore!
        
    @IBAction func addNewItem(_ sender: UIButton) {
        
        // Create a new item and add it to the store
        let newItem = itemStore.createitem()
        // Figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If you are currently in editing mode...
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
                     // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           let statusBarHeight = UIApplication.shared.statusBarFrame.height
           let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
           
           tableView.contentInset = insets
           tableView.scrollIndicatorInsets = insets
       
       // add footer to always show No more item
       let footer = UITableViewCell()
       footer.textLabel?.text = "No More Items"
       tableView.tableFooterView = footer

       }
        
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return itemStore.allItems.count
          
        }
        
      
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // this is better for memory management but must be configued in IB
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
          
          let item = itemStore.allItems[indexPath.row]
          cell.textLabel?.text = item.name
          cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            
            return cell
            
        }
      
      override func tableView(_ tableView: UITableView,
                              commit editingStyle: UITableViewCell.EditingStyle,
                              forRowAt indexPath: IndexPath) {
          // If the table view is asking to commit a delete command...
          if editingStyle == .delete {
              let item = itemStore.allItems[indexPath.row]
              // Remove the item from the store
            itemStore.removeItem(item)
              // Also remove that row from the table view with an animation
              tableView.deleteRows(at: [indexPath], with: .automatic)
          }
      }
      
      
      override func tableView(_ tableView: UITableView,
                              moveRowAt sourceIndexPath: IndexPath,
         // Update the model
      to destinationIndexPath: IndexPath) {
          itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
      }
    }


