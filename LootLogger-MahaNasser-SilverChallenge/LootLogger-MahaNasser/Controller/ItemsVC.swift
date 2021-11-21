//
//  ItemsVC.swift
//  LootLogger-MahaNasser
//
//  Created by Maha S on 14/11/2021.
//
import UIKit

class ItemsVC: UITableViewController {
  
  var itemStore: ItemStore!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
    
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
    updateUI()
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
  

  func updateUI() {
    if itemStore.allItems.count == 0{
      let noItems: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
      noItems.text = "No items!"
      noItems.textColor = UIColor.black
      noItems.textAlignment = NSTextAlignment.center
      self.tableView.backgroundView = noItems
    }else {
      self.tableView.backgroundView = nil
    }
    
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemStore.allItems.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    let item = itemStore.allItems[indexPath.row]
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars!)"
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      itemStore.removeItem(item)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      updateUI()
    }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
}
