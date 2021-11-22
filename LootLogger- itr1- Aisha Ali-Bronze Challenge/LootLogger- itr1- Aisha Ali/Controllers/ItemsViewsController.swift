//
//  TableVC.swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 11/14/21.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var filteredItems = [[Item]]()
  
  var itemStore: ItemStore!
  
  let moreThan50Section = 0
  let otherSection = 1
  
  var morethan50Empty: Bool {
    get { return itemStore.allItems.filter{getSectionOf(item: $0) == moreThan50Section}.count == 0 }
  }
  
  var otherSectionsEmpty: Bool {
    get { return itemStore.allItems.filter{getSectionOf(item: $0) == otherSection}.count == 0 }
  }
  
  
  
  @IBAction func addNewItem(_ sender: UIButton) {
    let moreThan50 = morethan50Empty
    let otherSections = otherSectionsEmpty
    
    let newItem = itemStore.createItem()
    
    //  I get the section of the new item
    let section = getSectionOf(item: newItem)
    
    //  when empty rows, don´t add another one
    if (section == moreThan50Section && moreThan50) ||
        (section == otherSection && otherSections) {
      tableView.reloadData()
      return
    }
    
    //  I calculate the index based on the array of items in the same section
    if let index = itemStore.allItems.filter({ getSectionOf(item: $0) == section }).firstIndex(of: newItem) {
      
      let indexPath = IndexPath(row: index, section: section)
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
    return 2
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

    if (section == moreThan50Section && morethan50Empty) ||
        (section == otherSection && otherSectionsEmpty) {
      return 1
    } else {
      
      let moreThan50SectionCount = itemStore.allItems.filter { getSectionOf(item: $0) == moreThan50Section } .count
      
      if section == moreThan50Section {
        
        return moreThan50SectionCount
      } else {
        
        return itemStore.allItems.count - moreThan50SectionCount
      }
    }
  }
  
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let item = itemStore.allItems.filter{ getSectionOf(item: $0) == indexPath.section } [indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    return cell
  }
  
  
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
  
  
  func getSectionOf(item :Item) -> Int {
    
    return item.valueInDollars > 50 ? moreThan50Section : otherSection
  }
  
}
