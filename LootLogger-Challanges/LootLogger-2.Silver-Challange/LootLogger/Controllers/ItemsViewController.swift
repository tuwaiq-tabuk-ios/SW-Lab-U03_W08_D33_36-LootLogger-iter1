
import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  
  
  @IBAction func addNewItem(_ sender: UIButton) {
    
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index,
                                section: 0)
      
      tableView.insertRows(at: [indexPath],
                           with: .automatic)
      
    }
  }
  
  
  @IBAction func toggleEditingMode(_ sender: UIButton) {
    
    if isEditing {
      sender.setTitle("Edit",
                      for: .normal)
      
      setEditing(false,
                 animated: true)
    } else {
      
      sender.setTitle("Done",
                      for: .normal)
      
      setEditing(true,
                 animated: true)
    }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return itemStore.otherItems.count
    }
    else {
      return (itemStore.highValueItems.count) + 1
    }
  }
  
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell
    = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                    for: indexPath)
    if indexPath.section == 0 {
      let item = itemStore.otherItems[indexPath.row]
      cell.textLabel?.text = item.name
      cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
      
    } else {
      
      if indexPath.row == itemStore.highValueItems.count{
        cell.textLabel?.text = "No more items!"
        cell.detailTextLabel?.text = nil
        
      } else {
        
//        let item = itemStore.highValueItems[indexPath.row]
        let item = itemStore.highValueItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
      }
    }
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row,
                       to: destinationIndexPath.row)
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 2
  }
  
  
  override func tableView(_ tableView: UITableView,
                          titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Under 50 USD"
    } else {
      return "Over 50 USD"
    }
  }
}
