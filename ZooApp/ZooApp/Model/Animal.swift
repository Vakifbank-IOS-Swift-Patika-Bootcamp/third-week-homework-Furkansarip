//
//  Animal.swift
//  ZooApp
//
//  Created by Furkan Sarı on 20.11.2022.
//

import Foundation



struct Animal {
    let name : String
    var waterConsumption : Int
    let keeper : Keeper
    let animalType : String
    
    init(name: String, waterConsumption: Int, keeper: Keeper,animalType:String) {
        self.name = name
        self.waterConsumption = waterConsumption
        self.keeper = keeper
        self.animalType = animalType
    }
}
