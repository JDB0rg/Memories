//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Madison Waters on 9/12/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print ("Count \(memoryController?.memories.count ?? 0)")
        return memoryController?.memories.count ?? 0
///////////////// After Save Count is still 0 /////////////////
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoryCell", for: indexPath)

        // Configure the cell...
        guard let memory = memoryController?.memories[indexPath.row] else { return cell }
        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData)
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let memory = memoryController?.memories[indexPath.row] else { return }
            memoryController?.delete(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation
    // addMemorySegue // detailViewSegue
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addMemorySegue" {
            guard let addMemoryVC = segue.destination as?
                MemoryDetailViewController else { return }
            
            addMemoryVC.memoryController = memoryController
            
        } else if segue.identifier == "detailViewSegue" {
            guard let detailViewVC = segue.destination as?
                MemoryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let memory = memoryController?.memories[indexPath.row]
            detailViewVC.memoryController = memoryController
            detailViewVC.memory = memory
        }
    }

    var memoryController: MemoryController?
}
