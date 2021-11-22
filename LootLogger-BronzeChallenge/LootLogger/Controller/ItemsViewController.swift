//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by bushra nazal alatwi on 10/04/1443 AH.
//
import Foundation
import UIKit
class ItemsViewController: UITableViewController {
  
//  var itemStore: ItemStore!
  //BronzCh
  var filteredItems = [[Item]]()
      var itemStore: ItemStore! {
          didSet {
              // reload table each time new data is set
              filteredItems = itemStore.filterItemsBy()
              self.tableView.reloadData()
          }
      }
  
  
  override func viewDidLoad() {
          super.viewDidLoad()
          
          let statusBarHeight = UIApplication.shared.statusBarFrame.height
          let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
          
          tableView.contentInset = insets
          tableView.scrollIndicatorInsets = insets
      }
  
  
  @IBAction func addNewItem(_ sender: UIButton) {
    // Create a new item and add it to the store
        let newItem = itemStore.createItem()
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
  
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
//   return itemStore.allItems.count
    return filteredItems[section].count
    
  }
  
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Create an instance of UITableViewCell with default appearance
    let item = filteredItems[indexPath.section][indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the table view
//    let item = itemStore.allItems[indexPath.row]
    
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         switch section {
         case 0:
             return "Over $50"
         case 1:
             return "Under $50"
         default:
             return nil
         }
     }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
          return filteredItems.count
      }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.tableView.reloadData()
  }
      
}
