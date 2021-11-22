//
//  ItemStore.swift
//  LootLogger
//
//  Created by bushra nazal alatwi on 09/04/1443 AH.
//

import UIKit

class ItemStore {
  
  var allItems = [Item]()
  
  
  @discardableResult func createItem() -> Item {
    let newItem = Item(random: true)
    allItems.append(newItem)
    return newItem
  }
  
  
  func removeItem(_ item: Item) {
      if let index = allItems.firstIndex(of: item) {
          allItems.remove(at: index)
      }
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
  }


