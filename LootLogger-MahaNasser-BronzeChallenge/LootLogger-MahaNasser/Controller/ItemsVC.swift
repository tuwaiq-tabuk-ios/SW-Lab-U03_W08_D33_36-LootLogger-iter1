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
  }
  
  
  
  @IBAction func addNewItem(_ sender: UIButton) {
  
    let newItem = itemStore.createItem()
    if (newItem.valueInDollars! >= 50){
      if let index = itemStore.upTo50.firstIndex(of: newItem) {
        let indexPath = IndexPath(row: index, section: 0)
        // Insert this new row into the table
        tableView.insertRows(at: [indexPath], with: .automatic)
      }
    }else{
      if let index = itemStore.downTo50.firstIndex(of: newItem) {
        let indexPath = IndexPath(row: index, section: 1)
        // Insert this new row into the table
        tableView.insertRows(at: [indexPath], with: .automatic)
      }
    }
  }
  
  
  @IBAction func toggleEditingMode(_ sender: UIButton) {
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
  
  
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection
                          section: Int) -> String? {
    if section == 0 {
      return "More than $50"
    } else {
      return "Less than $50"
    }
  }
  
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return itemStore.upTo50.count
      
    }else {
      return itemStore.downTo50.count
    }
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get a new or recycled cell
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath)
    if indexPath.section == 0 {
      let item = itemStore.upTo50[indexPath.row]
      cell.textLabel?.text = item.name
      cell.detailTextLabel?.text = "$\(item.valueInDollars!)"
    } else if indexPath.section == 1 {
      let item = itemStore.downTo50[indexPath.row]
      cell.textLabel?.text = item.name
      cell.detailTextLabel?.text = "$\(item.valueInDollars!)"
    }
    
    
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    let item:Item!
    if editingStyle == .delete {
      if indexPath.section == 0 {
        item = itemStore.upTo50[indexPath.row]
      } else {
        item = itemStore.downTo50[indexPath.row]
      }
      itemStore.removeItem(item)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    
    itemStore.moveItem(sourceIndexPath.section,from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
}
