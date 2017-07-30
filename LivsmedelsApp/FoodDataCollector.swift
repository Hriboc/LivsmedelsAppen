//
//  FoodDataCollector.swift
//  LivsmedelsApp
//
//  Created by Hristijan Bocevski on 2017-02-22.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

import Foundation

class FoodDataCollector {
    
    var _searchWord: String?
    var foods = [Food]()
    
    // Used for nutrition search result
    var food = Food();
    
    var tableViewController : TableViewController!
    var detailedViewController : DetailedViewController!
    
    var searchedWord : String {
        get {
            return _searchWord!
        } set {
            _searchWord = newValue
        }
    }
    
    var foodsList : [Food] {
        get {
            return foods
        }
    }
    
    // Call the food API with give search word and recive a list of hits
    func searchFood() {
        let urlString = "http://www.matapi.se/foodstuff?query=\(_searchWord!)"
        
        if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do{
                        if let foods = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [[String:Any]] {
                            for aFood in foods {
                                let name = aFood["name"] as? String
                                let number = aFood["number"] as? Int
                                let food = Food(name: name!, number: number!)
                                self.foods.append(food)
                            }
                            self.tableViewController.tableView.reloadData()
                            
                        }else {
                            NSLog("Failed typecasting from json")
                        }
                    }
                    catch let parseError {
                        NSLog("Failed parse json: \(parseError)")
                    }
                } else {
                    NSLog("No data received")
                }
            }
            task.resume()
        }
            
        else {
            NSLog("Failed creating url")
        }
        
    }
    
    // Call the food API with given food number and receive its nutrition
    func searchNutrition(foodNo: Int) {
        let urlString = "http://www.matapi.se/foodstuff/\(foodNo)"
        
        if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do{
                        if let parsed = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {
                            
                            let nutrientValues = parsed["nutrientValues"] as? [String:Any]
                            self.food.protein = nutrientValues?["protein"] as? Float
                            self.food.fat = nutrientValues?["fat"] as? Float
                            self.food.carbohydrates = nutrientValues?["carbohydrates"] as? Float
                            self.food.fibres = nutrientValues?["fibres"] as? Float
                            self.food.salt = nutrientValues?["salt"] as? Float
                            
                            self.detailedViewController.updateNutrientValues()
                            
                        }else {
                            NSLog("Failed typecasting from json")
                        }
                    }
                    catch let parseError {
                        NSLog("Failed parse json: \(parseError)")                    }
                } else {
                    NSLog("No data received")
                }
            }
            task.resume()
        }
            
        else {
            NSLog("Failed creating url")
        }
    }
}

