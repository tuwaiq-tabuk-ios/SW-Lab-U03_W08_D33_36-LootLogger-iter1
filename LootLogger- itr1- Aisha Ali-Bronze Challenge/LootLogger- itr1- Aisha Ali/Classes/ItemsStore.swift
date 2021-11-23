//
//  ItemsStore.swift
//  LootLogger- itr1- Aisha Ali
//
//  Created by Aisha Ali on 11/15/21.
//

import UIKit

class ItemStore {

  var allItems = [Item]()


  @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)

    allItems.append(newItem)

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


