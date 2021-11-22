//
//  ItemStore.swift
//  LootLogger-Abduaziz_hussun
//
//  Created by azooz alhwiti on 11/04/1443 AH.
//

import Foundation
//متجر العناصرItemStore
class ItemStore {
  var allItems = [Item]()
  
//  init() {
//    for _ in 0..<6 {     //عدد العناصر في المصفوفه
//      createItem()
//    }
//  }
                           //انشاء عنصرcreateItem
  @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    //اظافهappend
    allItems.append(newItem)
    return newItem
  }
  
  func removeItem(_ item: Item) {
      if let index = allItems.firstIndex(of: item) {
          allItems.remove(at: index)
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
