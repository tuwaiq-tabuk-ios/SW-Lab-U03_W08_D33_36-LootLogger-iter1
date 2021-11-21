//
//  ItemStore.swift
//  LootLogger
//
//  Created by Marzouq Almukhlif on 09/04/1443 AH.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    var upTo50 = [Item]()
    var downTo50 = [Item]()
  @discardableResult func createItem() -> Item {
      let newItem = Item(random: true)
    if newItem.valueInDollars! >= 50 {
      upTo50.append(newItem)
    }else{
      downTo50.append(newItem)
    }
      return newItem
  }
  
  func removeItem(_ item: Item) {
    if item.valueInDollars! >= 50 {
      if let index = upTo50.firstIndex(of: item) {
          upTo50.remove(at: index)
      }
    } else {
        if let index = downTo50.firstIndex(of: item) {
            downTo50.remove(at: index)
        }
    }
    
      
  }
  
  func moveItem(_ section: Int,from fromIndex: Int, to toIndex: Int) {
      if fromIndex == toIndex { return }
    
    if section == 0 {
      // Get reference to object being moved so you can reinsert it
      let movedItem = upTo50[fromIndex]
      // Remove item from array
      upTo50.remove(at: fromIndex)
      // Insert item in array at new location
      upTo50.insert(movedItem, at: toIndex)
    } else if section == 1 {
      // Get reference to object being moved so you can reinsert it
      let movedItem = downTo50[fromIndex]
      // Remove item from array
      downTo50.remove(at: fromIndex)
      // Insert item in array at new location
      downTo50.insert(movedItem, at: toIndex)
    }
      
  }
}
