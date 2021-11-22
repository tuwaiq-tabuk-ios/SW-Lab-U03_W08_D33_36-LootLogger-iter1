//
//  ItemsViewController.swift
//  LootLogger-MohaammedAloqbi
//
//  Created by Mohammed on 13/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  let sections = ["Over $50","$50 or Less"]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  @IBAction func addNewItem(_ sender: UIButton) {
    
    let newItem = itemStore.createItem()

    if let index = itemStore.over50Items.firstIndex(of: newItem) {
      
      let indexPath = IndexPath(row: index, section: 0)

      tableView.insertRows(at: [indexPath], with: .automatic)

      print("Item Name: \(newItem.name)")
      print("Value: \(newItem.valueInDollars)")
      
      
      
    } else if let index = itemStore.under50Items.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 1)
      tableView.insertRows(at: [indexPath], with: .automatic)

      print("Item Name: \(newItem.name)")
      print("Value: $\(newItem.valueInDollars)")
      
      
    }
  }
  @IBAction func toggleEdittingMode(_ sender: UIButton) {
    if isEditing {
      
      sender.setTitle("Edit", for: .normal)
      
      setEditing(false, animated: true)
    } else {
      
      sender.setTitle("Done", for: .normal)
      
      setEditing(true, animated: true)
    }
  }
  

  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return sections.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return itemStore.over50Items.count
    } else {
      return itemStore.under50Items.count
    }
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

    if indexPath.section == 0 {
      cell.textLabel?.text = itemStore.over50Items[indexPath.row].name
      cell.detailTextLabel?.text = "$\(itemStore.over50Items[indexPath.row].valueInDollars)"
      return cell
    } else  {
      cell.textLabel?.text = itemStore.under50Items[indexPath.row].name
      cell.detailTextLabel?.text = "$\(itemStore.under50Items[indexPath.row].valueInDollars)"
      return cell
    }
  }
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      
      if indexPath.section == 0{
        itemStore.removeItem(itemStore.over50Items[indexPath.row])
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
      } else  {
        
        itemStore.removeItem(itemStore.under50Items[indexPath.row])
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
      }
      
      
    }
    
  }
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  override func tableView(_ tableView: UITableView, titleForHeaderInSection
                            section: Int) -> String? {
    if section == 0 {
      return sections[0]
    } else {
      return sections[1]
    }
  }
}
