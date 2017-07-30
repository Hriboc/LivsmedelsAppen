//
//  Food.swift
//  LivsmedelsApp
//
//  Created by Hristijan Bocevski on 2017-07-29.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

import Foundation

class Food {
    var name : String?
    var number : Int?
    
    // Nutrients
    var protein : Float?
    var fat : Float?
    var carbohydrates : Float?
    var fibres : Float?
    var salt : Float?
    
    init(){}
    
    init(name : String, number : Int) {
        self.name = name
        self.number = number
    }
    
    func calculateNutrition() -> Float{
        return Float(protein!) * 2 + Float(fat!) * 2 + Float(carbohydrates!) + Float(fibres!) + Float(salt!)
    }
}
