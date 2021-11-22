//
//  ViewController.swift
//  LootLogger
//
//  Created by Ahmed awadh alqhtani on 12/04/1443 AH.
//

import UIKit

class ItemsViewController:UITableViewController {
  
  var filteredItems = [[Item]]()
  let sections = ["Over $50","$50 or Less"]
       var itemStore: ItemStore! {
        
           didSet {
               // reload table each time new data is set
               filteredItems = itemStore.filterItemsBy()
               self.tableView.reloadData()
           }
       }
  
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    if let index = itemStore.up50.firstIndex(of: newItem) {
      
      let indexPath = IndexPath(row: index, section: 0)

      tableView.insertRows(at: [indexPath], with: .automatic)

      print("Item Name: \(newItem.name)")
      print("Value: \(newItem.valueInDollars)")
      
      
      
    } else if let index = itemStore.under50.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 1)
      tableView.insertRows(at: [indexPath], with: .automatic)

      print("Item Name: \(newItem.name)")
      print("Value: $\(newItem.valueInDollars)")
      
      
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if section == 0 {
        return itemStore.up50.count
      } else {
        return itemStore.under50.count
      }
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Get a new or recycled cell
         let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
             for: indexPath)
      // Set the text on the cell with the description of the item
      // that is at the nth index of items, where n = row this cell
      // will appear in on the table view
      if indexPath.section == 0 {
        cell.textLabel?.text = itemStore.up50[indexPath.row].name
        cell.detailTextLabel?.text = "$\(itemStore.up50[indexPath.row].valueInDollars)"
        return cell
      } else  {
        cell.textLabel?.text = itemStore.under50[indexPath.row].name
        cell.detailTextLabel?.text = "$\(itemStore.under50[indexPath.row].valueInDollars)"
        return cell
      }
      
    }
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        
        if indexPath.section == 0{
          itemStore.removeItem(itemStore.up50[indexPath.row])
          
          tableView.deleteRows(at: [indexPath], with: .automatic)
          
        } else  {
          
          itemStore.removeItem(itemStore.under50[indexPath.row])
          
          tableView.deleteRows(at: [indexPath], with: .automatic)
          
        }
        
        
      }
    }
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
       // Update the model
    to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
  }
