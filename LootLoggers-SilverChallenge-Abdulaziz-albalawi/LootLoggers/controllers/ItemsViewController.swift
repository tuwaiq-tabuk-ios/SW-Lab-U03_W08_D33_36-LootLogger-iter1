//
//  ItemsViewController.swift
//  LootLoggers
//
//  Created by عبدالعزيز البلوي on 12/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
    
  }
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem) {
      let indexPath = IndexPath(row: index, section: 0)
      tableView.insertRows(at: [indexPath], with: .automatic)
      updateUI()
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
  
  
  func updateUI() {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
    tableView.contentInset = insets
    tableView.scrollIndicatorInsets = insets
    
    let footerView = UIView()
    let footColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    footerView.backgroundColor = footColor
    footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
    let footLabel = UILabel()
    footLabel.text = " No more items!"
    footerView.addSubview(footLabel)
    footLabel.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
    footLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
    footLabel.leftAnchor.constraint(equalTo: footerView.leftAnchor).isActive = true
    footLabel.rightAnchor.constraint(equalTo: footerView.rightAnchor).isActive = true
    footLabel.translatesAutoresizingMaskIntoConstraints = false
    footLabel.adjustsFontForContentSizeCategory = true
    
    if itemStore.allItems.count == 0 {
      tableView.tableFooterView = footerView
    } else {
      tableView.tableFooterView = nil
    }
  }
  
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return itemStore.allItems.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                             for: indexPath)
    let item = itemStore.allItems[indexPath.row]
    // Configure the cell...
    
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    return cell
  }
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
      updateUI()
    }
    
  }
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
