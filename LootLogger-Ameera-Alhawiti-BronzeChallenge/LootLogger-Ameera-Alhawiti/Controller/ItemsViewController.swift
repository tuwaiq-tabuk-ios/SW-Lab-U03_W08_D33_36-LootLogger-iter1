//
//  ItemsViewController.swift
//  LootLogger-Ameera-Alhawiti
//
//  Created by Ameera BA on 15/11/2021.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var filteredItems = [[Item]]()
  var itemStore: ItemStore! {
    didSet {
      filteredItems = itemStore.filterItemsBy()
      self.tableView.reloadData()
//      self.tableView.reloadData()
    }
  }
  
  
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 0)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  @IBAction func toggleEditingMode(_ sender: UIButton) {
    if isEditing {
      sender.setTitle("Edit", for: .normal)
      setEditing(false, animated: true)
    } else {
      sender.setTitle("Done", for: .normal)
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
  
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return filteredItems[section].count
  }
  
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = filteredItems[indexPath.section][indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if indexPath.row >= itemStore.allItems.count {
      return nil
    }
    return indexPath
  }
  
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    if editingStyle == .delete, indexPath.section < 1 {
      let item = itemStore.allItems[indexPath.row]
      
      let title = "Remove \(item.name)?"
      let message = "Are you sure you want to remove this item?"
      let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      ac.addAction(cancelAction)
      
      let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: {(action) -> Void in
        
        self.itemStore.removeItem(item)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      })
      
      ac.addAction(deleteAction)
      present(ac, animated: true, completion: nil)
    }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
  override func tableView(_ tableView: UITableView,
                          titleForHeaderInSection section: Int
  ) -> String? {
    switch section {
    case 0:
      return "Over $50"
    case 1:
      return "Under $50"
    default:
      return nil
    }
  }
}
