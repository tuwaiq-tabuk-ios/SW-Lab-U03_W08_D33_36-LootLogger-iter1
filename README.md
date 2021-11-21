# SW-Lab-U03_W08_D33_36-LootLogger-iter1
First iteration of LootLogger App where users can add, delete and move Item instances in a UITableView

## Topics
1. _**Table view controller hierarchy**_
   - `UITableViewController`
      - var `tableView`: `UITableView`
   - `UIViewController` 
      - var `view`: `UIView`
   - Protocols `UITableViewDataSource` and `UITableViewDelegate`
2. `@discardableResult` annotation.
3. _**Dependency injection**_ to decouple High-level objects from low-level objects.
4. _**Table view cell hierarchy**_
   - var `textLabel`: `UILabel`
   - var `detailTextLabel`: `UILabel`
   - `UITableViewCellAccessoryType`
5. Reusing Table view cells
6. Editing table views
   - Editing mode
   - Adding rows 
   - Deleting rows
   - Moving rows


## Description
1. First iteration of LootLogger App where users can add, delete, and move `Item` instances in a `UITableView`.
2. Bronze challenge: _**Sections**_
   - Have the `UITableView` display two sections – one for items worth more than $50 and one for the rest. 
3. Silver challenge: _**Constant Rows**_
   - Make it so that if there are no items, the `UITableView` displays a cell that has the text No items!. This row should not appear if there are items to display, and it should not be able to be deleted or reordered. 


## Deadline 
Monday 22nd November 9:15 am


