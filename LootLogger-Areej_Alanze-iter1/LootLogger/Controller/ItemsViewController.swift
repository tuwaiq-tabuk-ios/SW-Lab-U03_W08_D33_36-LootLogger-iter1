//
//  ViewController.swift
//  LootLogger
//
//  Created by A A on 14/11/2021.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  let sections = ["Over $50","$50 or Less"]
  
  
  
  @IBAction func addNewItem(_ sender: UIButton) {
    
    // Create a new item and add it to the store
    let newItem = itemStore.createItem()
    
    // Figure out where that item is in the array
    if let index = itemStore.over50Items.firstIndex(of: newItem) {
      
      let indexPath = IndexPath(row: index, section: 0)
      
      // Insert this new row into the table
      tableView.insertRows(at: [indexPath], with: .automatic)
      
      
      print("Item Name: \(newItem.name)")
      print("Value: \(newItem.valueInDollars)")
      
      
    } else if let index = itemStore.under50Items.firstIndex(of: newItem) {
      
      let indexPath = IndexPath(row: index, section: 1)
      tableView.insertRows(at: [indexPath], with: .automatic)
      
      // console stuff
      print("Item Name: \(newItem.name)")
      print("Value: $\(newItem.valueInDollars)")
      
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
    
    let footer = UITableViewCell()
    footer.textLabel?.text = "No More Items"
    tableView.tableFooterView = footer
    
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return itemStore.over50Items.count
    } else {
      return itemStore.under50Items.count
    }
    
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    if indexPath.section == 0 {
      cell.textLabel?.text = itemStore.over50Items[indexPath.row].name
      cell.detailTextLabel?.text = "$\(itemStore.over50Items[indexPath.row].valueInDollars)"
      return cell
    }
    
    else {
      cell.textLabel?.text = itemStore.under50Items[indexPath.row].name
      cell.detailTextLabel?.text = "$\(itemStore.under50Items[indexPath.row].valueInDollars)"
      return cell
    }
    
  }
  
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // If the table view is asking to commit a delete command...
    if editingStyle == .delete {
      
      if itemStore.over50Items.firstIndex(of: itemStore.over50Items[indexPath.row]) != nil {
        // remove the item from the store
        itemStore.removeItem(itemStore.over50Items[indexPath.row])
        
        // Also remove that row from the table view with an animation
        tableView.deleteRows(at: [indexPath], with: .automatic)
      } else {
        itemStore.removeItem(itemStore.under50Items[indexPath.row])
        // Also remove that row from the table view with an animation
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
      }
    }
  }
  
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row, within: sourceIndexPath.section)
  }
  
  
  // Create a standard header that includes the returned text.
  override func tableView(_ tableView: UITableView, titleForHeaderInSection
                            section: Int) -> String? {
    if section == 0 {
      return sections[0]
    } else {
      return sections[1]
    }
  }
  
  
  override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
    
    // I need to identify section
    let sourceSection = sourceIndexPath.section
    let destinationSection = proposedDestinationIndexPath.section
    
    // only allow the move if sections are the same, otherwise, slide them within the same section
    if destinationSection < sourceSection {
      return IndexPath(row: 0, section: sourceSection)
    } else if destinationSection > sourceSection {
      return IndexPath(row: self.tableView(tableView, numberOfRowsInSection: sourceSection)-1, section: sourceSection)
    }
    
    return proposedDestinationIndexPath
    
  }
  
}

