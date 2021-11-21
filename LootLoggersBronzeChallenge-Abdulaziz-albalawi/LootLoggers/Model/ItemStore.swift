//
//  ItemStore.swift
//  LootLoggers
//
//  Created by عبدالعزيز البلوي on 12/04/1443 AH.
//

import UIKit
class ItemStore  {
  var allItems = [Item]()
  var over50Items = [Item]()
  var under50Items = [Item]()
  
  @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    
    
    if newItem.valueInDollars > 50 {
      over50Items.append(newItem)
    } else {
      under50Items.append(newItem)
    }
    
    
    return newItem
  }
  
  func removeItem(_ item: Item) {
    if let index = over50Items.firstIndex(of: item) {
      over50Items.remove(at: index)
    } else if let index = under50Items.firstIndex(of: item){
      under50Items.remove(at: index)
    }
  }
  
  
  func moveItem(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return
      
    }
    
    // Get reference to object being moved so you can reinsert it
    
    let movedOver50Item = over50Items[fromIndex]
    
    
    over50Items.remove(at: fromIndex)
    
    over50Items.insert(movedOver50Item, at: toIndex)
    
    let movedUnder50Items = under50Items[fromIndex]
    under50Items.remove(at: fromIndex)
    under50Items.insert(movedUnder50Items, at: toIndex)
  }
}



