//
//  ItemsVC.swift
//  LootLogger-MahaNasser
//
//  Created by Maha S on 14/11/2021.
//

import UIKit

class ItemsVC: UITableViewController {
  
  var itemStore: ItemStore!
  
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

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemStore.allItems.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    
    let item = itemStore.allItems[indexPath.row]
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    
    return cell
    
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  
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
  
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
