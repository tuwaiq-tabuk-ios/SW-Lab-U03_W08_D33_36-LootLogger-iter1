//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Marzouq Almukhlif on 09/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  var showOnlyFavorit = false
  
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    itemStore.array = itemStore.allItems
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
  
  
  @IBAction func showOnlyFavorited(_ sender: UIButton) {
    if !showOnlyFavorit {
      sender.setTitle("Show All Items", for: .normal)
      showOnlyFavorit = true
      for item in itemStore.allItems {
        if item.isFavorite {
        itemStore.addToFavorit(item)
        }
      }
      itemStore.array = itemStore.favoritItems
      self.tableView.reloadData()
    } else {
      for item in itemStore.allItems {
        if item.isFavorite {
        itemStore.removeItemFromFavorit(item)
        }
      }
      itemStore.array = itemStore.allItems
      sender.setTitle("Show favorited", for: .normal)
      showOnlyFavorit = false
      self.tableView.reloadData()

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
    return itemStore.array.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath)
    let item = itemStore.array[indexPath.row]
    
    if item.isFavorite {
      cell.textLabel?.text = "\(item.name) (Favorite)"
    } else {
      cell.textLabel?.text = item.name
    }
    cell.detailTextLabel?.text = "$\(item.valueInDollars!)"
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let deleteAction = UIContextualAction(
      style: .normal,
      title: "Delete",
      handler: { (action, view, completion) in
        let item = self.itemStore.array[indexPath.row]
        self.itemStore.removeItem(item)
        tableView.deleteRows(at: [indexPath], with: .automatic);        completion(true)
      })
    deleteAction.backgroundColor = .red
    
    let item = self.itemStore.array[indexPath.row]
    let titleActionFavorite:String
    if item.isFavorite {
     titleActionFavorite = "UnFavorite"
    } else {
     titleActionFavorite = "Favorite"
    }
    
    let favoriteAction = UIContextualAction(
      style: .normal,
      title: titleActionFavorite,
      handler: { (action, view, completion) in
        let item = self.itemStore.array[indexPath.row]
        if item.isFavorite {
          item.isFavorite = false
        } else {
          item.isFavorite = true
        }
          self.tableView.reloadData()
        completion(true)
      })
    favoriteAction.backgroundColor = .systemYellow
    
    let configuration = UISwipeActionsConfiguration(actions: [deleteAction,favoriteAction])
    configuration.performsFirstActionWithFullSwipe = false
    return configuration
  }
  
//  override func tableView(_ tableView: UITableView,
//                          commit editingStyle: UITableViewCell.EditingStyle,
//                          forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//      let item = itemStore.allItems[indexPath.row]
//      itemStore.removeItem(item)
//      tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
//  }
  
  
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          // Update the model
                          to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
  
}
