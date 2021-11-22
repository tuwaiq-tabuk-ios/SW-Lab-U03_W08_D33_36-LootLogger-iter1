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
     
      
   //  itemStore.allItems.removeAll()
        
     }

  

  
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
          switch section {
          case 0:
              return "Under $50"
          case 1:
              return "Over $50"
          default:
              return nil
          }
      }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section
        {
        case 0 :
            if itemStore.otherItems.isEmpty
            {
                return "No items!."
            }else
            {
                return "No more items!"
            }
            
        case 1:
            if itemStore.highValueItems.isEmpty
            {
                return "No items!."
            }else
            {
                return "No more items!"
            }
           
        default:
            return " "
        }
    }
         
     
  
  
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    var sectionNumber = 0
     var index = 0
        if newItem.valueInDollars > 50
        {
            sectionNumber = 1
            index =   itemStore.highValueItems.firstIndex(of:newItem)!
        }else
        {
            index =  itemStore.otherItems.firstIndex(of:newItem)!
        }
      let indexPath = IndexPath(row: index, section: sectionNumber)
      tableView.insertRows(at: [indexPath], with:.automatic)
        tableView.reloadData()
    
  }
  
  
  @IBAction func toggleEditingMode(_ sender : UIButton){

    if isEditing {
      // Change text of button to inform user of state
      sender.setTitle("Edit", for: .normal)

      // Turn off editing mode
      setEditing(false, animated: true)
        tableView.reloadData()

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
    
      if  section == 0
      {
          if itemStore.otherItems.isEmpty
          {
              return 1
          }else
          {
              return itemStore.otherItems.count
          }
          
      }else
      {
          if itemStore.highValueItems.isEmpty
          {
            return 1
          }else
          {
              return itemStore.highValueItems.count
          }
      }
        

  }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        tableView.reloadData()
        let Fav = UIContextualAction(style: .normal, title: "Favorite"){(action,view,completionHandler) in
            
            
            if indexPath.section == 0
            {
                if !self.itemStore.otherItems[indexPath.row].isFavorite
                {
                    self.itemStore.otherItems[indexPath.row].isFavorite = true
               }
            }else
            {
                if !self.itemStore.highValueItems[indexPath.row].isFavorite
                 {
                    self.itemStore.highValueItems[indexPath.row].isFavorite = true
                }
            }
            completionHandler(true)
        }
        
        Fav.image = UIImage(systemName: "heart.fill")
        Fav.backgroundColor = .green
        let swipe = UISwipeActionsConfiguration(actions: [Fav])
        tableView.reloadData()
        
        return swipe
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     
        
        let unFav = UIContextualAction(style: .destructive, title: "UnFavorite"){(action,view,completionHandler) in
            completionHandler(true)
           
            if indexPath.section == 0
            {
                if self.itemStore.otherItems[indexPath.row].isFavorite
                {
                    self.itemStore.otherItems[indexPath.row].isFavorite = false
               }
            }else
            {
                if self.itemStore.highValueItems[indexPath.row].isFavorite
                 {
                    self.itemStore.highValueItems[indexPath.row].isFavorite = false
                }
            }
        }
        
        unFav.image = UIImage(systemName: "heart")
        unFav.backgroundColor = .orange
        let Delete = UIContextualAction(style: .normal, title: "Delete"){(action,view,completionHandler) in
            completionHandler(true)
            if indexPath.section == 0
            {
                let item = self.itemStore.otherItems[indexPath.row]
                self.itemStore.removeItem(item)
            }else if indexPath.section == 1
            {
                let item = self.itemStore.highValueItems[indexPath.row]
                self.itemStore.removeItem(item)
            }
            
        }
       
        Delete.image = UIImage(systemName: "trash")
        Delete.backgroundColor = .red
          let  swipe = UISwipeActionsConfiguration(actions: [unFav,Delete])
        
        tableView.reloadData()
        return swipe
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
      
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete
        {
            if indexPath.section == 0
            {
                let item = itemStore.otherItems[indexPath.row]
                itemStore.removeItem(item)
            }else if indexPath.section == 1
            {
                let item = itemStore.highValueItems[indexPath.row]
                itemStore.removeItem(item)
            }
        }
        tableView.reloadData()
    }
  override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Create an instance of UITableViewCell with default appearance
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath)
     
     
      if indexPath.section == 0
          {
          if !itemStore.otherItems.isEmpty
          {
              
                  let item = itemStore.otherItems[indexPath.row]
                  if itemStore.otherItems[indexPath.row].isFavorite
                  {
                      cell.textLabel?.text = item.name + " (Favorite)"
                  }
                  else
                  {
                      cell.textLabel?.text = item.name
                  }
                  
                  cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
              }
                
          
      }
      if indexPath.section == 1  {
         if !itemStore.highValueItems.isEmpty
          {
          
              let item = itemStore.highValueItems[indexPath.row]
             
              if itemStore.highValueItems[indexPath.row].isFavorite
              {
                  cell.textLabel?.text = item.name + " (Favorite)"
              }
              else
              {
                  cell.textLabel?.text = item.name
              }
              
              cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
          }
         
           
      }
          
      
        
        return cell
      }
  
 
  
  override func tableView(_ tableView: UITableView,moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
    
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  

  
}
