


import UIKit
class ItemStore {
    var allItems = [Item]()
     var lowRankedItems = [Item]()
     var highRankedItems = [Item]()
     let rankItem : (Item) -> Bool
  
  
  func createItem () -> Item {
          let newItem = Item(random: true)
          
          if rankItem(newItem) {
              highRankedItems.append(newItem)
          } else {
              lowRankedItems.append(newItem)
          }
          
          return newItem
      }
      
  init(rankItemFunc: @escaping (Item) -> Bool) {
          self.rankItem = rankItemFunc
          for _ in 0..<5 {
              createItem()
          }
      }
  
  
  
  
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
  

  
  
  

