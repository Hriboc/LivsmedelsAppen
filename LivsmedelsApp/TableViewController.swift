//
//  TableViewController.swift
//  LivsmedelsApp
//
//  Created by Hristijan Bocevski on 2017-02-22.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var searchWord = ""
    var foodDataCollector : FoodDataCollector!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodDataCollector = FoodDataCollector()
        foodDataCollector.tableViewController = self
        foodDataCollector.searchedWord = searchWord
        foodDataCollector.searchFood()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        NSLog("\(foodDataCollector.foods.count) items in the list")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodDataCollector.foodsList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = foodDataCollector.foodsList[indexPath.row].name

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailedViewController : DetailedViewController = segue.destination as! DetailedViewController
        // Gets the text from the senders cell
        if let cell = sender as? UITableViewCell {
            let foodName = cell.textLabel?.text
            
            detailedViewController.title = foodName
            // Get and set the food number in dest view so we can call the api with it for getting the nutrients
            for food in foodDataCollector.foodsList {
                if food.name == foodName {
                    detailedViewController.foodNo = food.number
                }
            }
        }
    }

}
