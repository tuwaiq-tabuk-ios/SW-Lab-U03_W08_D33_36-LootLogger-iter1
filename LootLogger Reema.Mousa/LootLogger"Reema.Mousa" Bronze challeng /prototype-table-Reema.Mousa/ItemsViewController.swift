//
//  ItemsViewController.swift
//  prototype-table-Reema.Mousa
//
//  Created by Reema Mousa on 10/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var filteredItems = [[Item]]()
  var itemStore: ItemStore! {
    didSet {
      // reload table each time new data is set
      filteredItems = itemStore.filterItemsBy()
      self.tableView.reloadData()
    }
  }
  
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem){
      let indexPath = IndexPath(row:index,section:0)
      
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  @IBAction func toggleEditingMode(_ sender: UIButton) {
    if isEditing == true{
      sender.setTitle("Edit", for: .normal)
      setEditing(false, animated: true);
    }else{
      sender.setTitle("Done",for:.normal)
      setEditing(true, animated: true)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
    
    tableView.contentInset = insets
    tableView.scrollIndicatorInsets = insets
  }
  override func numberOfSections(in tableView: UITableView) -> Int {
    return filteredItems.count
  }
  //do
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredItems[section].count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
    let item = filteredItems[indexPath.section][indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    return cell
    
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
  //169
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
  //169
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
}
