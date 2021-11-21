

import UIKit

class ItemStore {
  
  var allItems = [Item]()
  
  var highValueItems = [Item]()
  var otherItems = [Item]()
  let rankItem : (Item) -> Bool
  
  init(rankItemFunc: @escaping (Item) -> Bool){
    self.rankItem = rankItemFunc
    for _ in 0..<10 {
      createItem()
    }
  }
  
  @discardableResult func createItem() -> Item {
    
    let newItem = Item(random: true)
    
    if rankItem(newItem){
      highValueItems.append(newItem)
      
    } else {
      otherItems.append(newItem)
    }
    
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
