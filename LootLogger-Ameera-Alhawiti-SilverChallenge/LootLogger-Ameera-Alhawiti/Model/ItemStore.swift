//
//  ItemStore.swift
//  LootLogger-Ameera-Alhawiti
//
//  Created by Ameera BA on 15/11/2021.
//

import UIKit

class ItemStore {
  
  var allItems = [Item]()
  var highValueItems: [Item] {
      return allItems.filter{ $0.valueInDollars > 50 }
    }
    
  var otherItems: [Item] {
      return allItems.filter{ $0.valueInDollars <= 50 }
    }
  
  
  @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    allItems.append(newItem)
    
    return newItem
  }
  
  
  func insertNoItems() {
    let newItem = Item(name: "No more items!",
                       serialNumber: nil,
                       valueInDollars: 0)
    allItems.append(newItem)
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
  
  
  
  func removeItem(_ item: Item) {
    if let index = allItems.firstIndex(of: item) {
      allItems.remove(at: index)
    }
  }
  
  
  func moveItem(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return }
    
    let movedItem = allItems[fromIndex]
    allItems.remove(at: fromIndex)
    allItems.insert(movedItem, at: toIndex)
  }
}
