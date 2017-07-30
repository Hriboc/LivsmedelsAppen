//
//  DetailedViewController.swift
//  LivsmedelsApp
//
//  Created by Hristijan Bocevski on 2017-07-30.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var lblProtein: UILabel!
    @IBOutlet weak var lblFat: UILabel!
    @IBOutlet weak var lblCarbohydrates: UILabel!
    @IBOutlet weak var lblFibres: UILabel!
    @IBOutlet weak var lblSalt: UILabel!
    @IBOutlet weak var lblNutrition: UILabel!
    
    var foodNo : Int!
    var foodDataCollector : FoodDataCollector!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        foodDataCollector = FoodDataCollector()
        foodDataCollector.detailedViewController = self
        foodDataCollector.searchNutrition(foodNo: foodNo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateNutrientValues(){
        DispatchQueue.main.async {
            self.lblProtein.text = String(self.foodDataCollector.food.protein!)
            self.lblFat.text = String(self.foodDataCollector.food.fat!)
            self.lblCarbohydrates.text = String(self.foodDataCollector.food.carbohydrates!)
            self.lblFibres.text = String(self.foodDataCollector.food.fibres!)
            self.lblSalt.text = String(self.foodDataCollector.food.salt!)
            self.lblNutrition.text = String(self.foodDataCollector.food.calculateNutrition())
        }
    }
}
