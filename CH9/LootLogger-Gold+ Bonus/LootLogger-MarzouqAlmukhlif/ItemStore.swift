//
//  ItemStore.swift
//  LootLogger
//
//  Created by Marzouq Almukhlif on 09/04/1443 AH.
//

import UIKit

class ItemStore {
    var array = [Item]()
    var allItems = [Item]()
    var favoritItems = [Item]()

  @discardableResult func createItem() -> Item {
      let newItem = Item(random: true)
      allItems.append(newItem)
      return newItem
  }
  
  func removeItem(_ item: Item) {
      if let index = array.firstIndex(of: item) {
        array.remove(at: index)
      }
    if let index = allItems.firstIndex(of: item) {
      allItems.remove(at: index)
    }
    if let index = favoritItems.firstIndex(of: item) {
      favoritItems.remove(at: index)
    }
  }
  
  func addToFavorit(_ item:Item){
    favoritItems.append(item)
  }
  
  func removeItemFromFavorit(_ item:Item){
    if let index = favoritItems.firstIndex(of: item) {
      favoritItems.remove(at: index)
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
