//
//  ViewController.swift
//  ZooApp
//
//  Created by Furkan Sarı on 18.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var keeperCountLabel: UILabel!
    @IBOutlet weak var animalCountLabel: UILabel!
    @IBOutlet weak var stockWaterLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    
    @IBOutlet weak var incomeOrExpenseTextField: UITextField!
    @IBOutlet weak var increaseWaterTextField: UITextField!
    
    @IBOutlet weak var paySalaryButton: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var expenseButton: UIButton!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var addKeeperButton: UIButton!
    @IBOutlet weak var addAnimalButton: UIButton!
    @IBOutlet weak var ListButton: UIButton!
    
    private var totalSalary = 0.0
    private var budget = Zoo.shared.getBudget()
    var stockWater = 0
    var keeperListCount = Zoo.shared.allKeeperList().count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetLabel.text = "Budget : \(budget)"
        let keep = Keeper(name: "Keeper1", experience: "5", age: "5",salary: 5500)
        let keep2 = Keeper(name: "Keeper2", experience: "5", age: "5",salary: 10500)
        let animal1 = Animal(name: "Cat", waterConsumption: 5, keeper: keep, animalType: "Cat")
        let animal2 = Animal(name: "Cow", waterConsumption: 5, keeper: keep, animalType: "Cow")
        let animal3 = Animal(name: "Bird", waterConsumption: 5, keeper: keep, animalType: "Bird")
       
        Zoo.shared.addKeeper(keeper: keep)
        Zoo.shared.addKeeper(keeper: keep2)
        Zoo.shared.addAnimal(animal: animal1)
        Zoo.shared.addAnimal(animal: animal2)
        Zoo.shared.addAnimal(animal: animal3)
      
        //stockWaterLabel.text = "Stock Water : \(stockWater)L"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        stockWater = Zoo.shared.getStockWater()
        stockWaterLabel.text = "Stock Water : \(stockWater)L"
        keeperListCount = Zoo.shared.allKeeperList().count
        keeperCountLabel.text = "Keeper Count : \(keeperListCount)"
    }
    
    @IBAction func stockWater(_ sender: Any) {// AddWater Butonu ile su ekleyebiliyoruz.
        guard let value = Int(increaseWaterTextField.text ?? "0.0") else { return }
        stockWater += value
        stockWaterLabel.text = "Stock Water : \(stockWater)L"
    }
    
    @IBAction func addOrExpense(_ sender: UIButton) { // Gelir - Gider
        guard let value = Double(incomeOrExpenseTextField.text ?? "0.0") else { return }
        if sender.titleLabel?.text == "+" {
            budget += value
            budgetLabel.text = "Budget : \(budget)"
        } else {
            budget -= value
            budgetLabel.text = "Budget : \(budget)"
        }
    }
    
    @IBAction func addKeeper(_ sender: Any) {
        performSegue(withIdentifier: "addKeeper", sender: nil)
    }
    
    @IBAction func addAnimal(_ sender: Any) {
        performSegue(withIdentifier: "addAnimal", sender: nil)
    }
    
    @IBAction func paySalary(_ sender: Any) {// Maaş Ödemesi
      totalSalary = Zoo.shared.payKeeperSalary()
        if budget < totalSalary { //Bütçe çalışanların toplam maaşından küçük ise ödeme yapılmıyor.
            showAlert(title: "Error", messages: "Insufficient Budget")
        } else {
            budget -= totalSalary
            budgetLabel.text = "Budget : \(budget)"
        }
        
    }
    
    @IBAction func list(_ sender: Any) {
        performSegue(withIdentifier: "listView", sender: nil)
    }
    func showAlert(title:String,messages:String){
        
        let alert = UIAlertController(title: title, message: messages, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

