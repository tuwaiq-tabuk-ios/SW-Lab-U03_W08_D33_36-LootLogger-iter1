//
//  Item.swift
//  LootLogger
//
//  Created by arwa balawi on 11/04/1443 AH.
//

import UIKit


class ItemsViewController : UITableViewController {
  

     var itemStore: ItemStore!
    
  
  override func viewDidLoad() {
         super.viewDidLoad()
         
        
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
  
  
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()

    if let index = itemStore.allItems.firstIndex(of:newItem){
      let indexPath = IndexPath(row: index, section: 0)
      tableView.insertRows(at: [indexPath], with:.automatic)
    }
  }
  
  
  @IBAction func toggleEditingMode(_ sender : UIButton){

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
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
         return itemStore.otherItems.count
       } else {
         return itemStore.highValueItems.count
       }
    
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Create an instance of UITableViewCell with default appearance
    
    let cell = tableView
      .dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    
    if indexPath.section == 0 {
          let item = itemStore.otherItems[indexPath.row]
          cell.textLabel?.text = item.name
          cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
        } else {
          let item = itemStore.highValueItems[indexPath.row]
          cell.textLabel?.text = item.name
          cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
        }
    return cell
  }
  
  
 
  
  override func tableView(_ tableView: UITableView,moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
    
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  

  
}
