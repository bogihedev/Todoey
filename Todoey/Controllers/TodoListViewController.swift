//
//  ViewController.swift
//  Todoey
//
//  Created by Bogi Eliasen on 4/10/19.
//  Copyright © 2019 Bogi Eliasen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

  var itemArray = [Item]()
  
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  //let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    loadItems()
    
//    if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//      itemArray = items
//    }
    // Do any additional setup after loading the view.
  }
  
  //This creates the number of cells
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    let item = itemArray[indexPath.row]
    
    cell.textLabel?.text = item.title
    
    cell.accessoryType = item.done ? .checkmark : .none
    
    return cell
  }
  
  //MARK - TableView delegate methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print(itemArray[indexPath.row])
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    self.saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  //MARK - Add new Items
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      //what will happen when the user clicks the Add Item button on the UIAlert
      let newItem = Item()
      newItem.title = textField.text!
      
      self.itemArray.append(newItem)
      
      //self.defaults.set(self.itemArray, forKey: "TodoListArray")
      let encoder = PropertyListEncoder()
      
      self.saveItems()
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  func saveItems(){
    let encoder = PropertyListEncoder()
    
    do{
      let data = try encoder.encode(itemArray)
      try data.write(to: dataFilePath!)
    } catch{
      print("Error encoding item array, \(error)")
    }
    
    
    self.tableView.reloadData()
  }
  
  func loadItems(){
    
    if let data = try? Data(contentsOf: dataFilePath!){
      let decoder = PropertyListDecoder()
      
      do{
        itemArray = try decoder.decode([Item].self, from: data)
        
      } catch {
        print("Error decoding item array, \(error)")
      }
      
    }
    
    
    
    
  }

}

