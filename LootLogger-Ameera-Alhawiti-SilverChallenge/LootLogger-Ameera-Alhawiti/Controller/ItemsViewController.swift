//
//  ItemsViewController.swift
//  LootLogger-Ameera-Alhawiti
//
//  Created by Ameera BA on 15/11/2021.
//

import UIKit

class ItemsViewController: UITableViewController {
  
    var itemStore: ItemStore!
  
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
    return 2
  }
  
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return itemStore.highValueItems.count
    default:
      return itemStore.otherItems.count + 1   // 1 for "No more items!"
    }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    let items: [Item]
    switch indexPath.section {
    case 0:
      items = itemStore.highValueItems
    default:
      items = itemStore.otherItems
    }
    
    if indexPath.section == 1 && indexPath.row == items.count {
      cell.textLabel?.text = "No more items!"
      cell.detailTextLabel?.text = ""
    } else {
      let item = items[indexPath.row]
      cell.textLabel?.text = item.name
      cell.detailTextLabel?.text = "\(item.valueInDollars)"
      cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
      cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      itemStore.removeItem(item)
      
      tableView.deleteRows(at: [indexPath], with: .automatic)
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
      return "More than $50"
    default:
      return "Others"
    }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 1 && indexPath.row == itemStore.otherItems.count {
      return 44
    } else {
      return 60
    }
  }
}
