//
//  Zoo.swift
//  ZooApp
//
//  Created by Furkan Sarı on 20.11.2022.
//

import Foundation


class Zoo {
    public static var shared = Zoo()
    private init(){}
    var keeperList = [Keeper]()
    var animalList = [Animal]()
    var stockWater = 500
    var budget = 100000.0
    
    func addKeeper(keeper : Keeper){
        keeperList.append(keeper)
    }
    func addAnimal(animal : Animal){
        animalList.append(animal)
    }
    
    func payKeeperSalary() -> Double {
        var totalSalary = 0.0
        for keeper in keeperList {
            totalSalary += keeper.salary
        }
        return totalSalary
    }
    func getStockWater() ->Int {//Hayvan eklendikçe stokta bulunan su değerimiz azalıcak.
        var totalConsumption = 0
        for animal in animalList {
           totalConsumption += animal.waterConsumption
            print("total \(totalConsumption)")
        }
        stockWater -= totalConsumption
        print(stockWater)
        return stockWater
    }
    func getBudget() -> Double {
        return budget
    }
    
    func allKeeperList() -> [Keeper] {
        return keeperList
    }
    
    func allAnimalList() -> [Animal] {
        return animalList
    }
    
}
