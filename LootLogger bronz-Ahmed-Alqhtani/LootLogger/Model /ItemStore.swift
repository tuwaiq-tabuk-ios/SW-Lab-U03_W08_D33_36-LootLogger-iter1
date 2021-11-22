//
//  ItemStore.swift
//  LootLogger
//
//  Created by Ahmed awadh alqhtani on 12/04/1443 AH.
//


import UIKit
class ItemStore {
  var allItems = [Item]()
  var up50 = [Item]()
  var under50 = [Item]()

  @discardableResult func createItem() -> Item {
      let newItem = Item(random: true)
    if newItem.valueInDollars > 50 {
      up50.append(newItem)
    } else {
      under50.append(newItem)
    }
    
      return newItem
  }
  
  func filterItemsBy(_ price: Int = 50) -> [[Item]] {
         var filteredItems = [[Item](), [Item]()]
         for item in allItems {
             if item.valueInDollars > price {
                 filteredItems[0].append(item)
             } else {
                 filteredItems[1].append(item)
             }
         }
         return filteredItems
     }
     
     init() {
         for _ in 0..<5 {
             createItem()
         }
     }
  func removeItem(_ item: Item) {
    if let index = up50.firstIndex(of: item) {
      up50.remove(at: index)
    } else if let index = under50.firstIndex(of: item){
      under50.remove(at: index)
    }
  }
  
  func moveItem(from fromIndex: Int, to toIndex: Int) {
      if fromIndex == toIndex {
  return }
      // Get reference to object being moved so you can reinsert it
      let movedItem = allItems[fromIndex]
      // Remove item from array
      allItems.remove(at: fromIndex)
      // Insert item in array at new location
      allItems.insert(movedItem, at: toIndex)
  }
}

