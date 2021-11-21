//
//  ItemStore.swift
//  prototype-table-Reema.Mousa
//
//  Created by Reema Mousa on 10/04/1443 AH.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item{
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func moveItem(from fromIndex: Int,to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem,at:toIndex)
    }
    
    func removeItem(_ item: Item){
        if let index = allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
}

