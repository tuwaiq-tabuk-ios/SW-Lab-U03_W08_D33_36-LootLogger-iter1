//
//  TableVC.swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 11/14/21.
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
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return itemStore.allItems.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath)
    
    
    let cell = UITableViewCell(style: .value1,reuseIdentifier: "UITableViewCell")
    let item = itemStore.allItems[indexPath.row]
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    return cell
  }
  
  
  //MARK: - Delete Rows
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      itemStore.removeItem(item)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  override func tableView(_ tableView: UITableView,moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
    
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
  
}