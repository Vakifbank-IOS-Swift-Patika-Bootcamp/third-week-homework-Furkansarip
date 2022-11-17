//
//  ViewController.swift
//  CompanyApp
//
//  Created by Furkan Sarı on 14.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var incomeTextField: UITextField!
    
    @IBOutlet weak var paySalaryButton: UIButton!
    @IBOutlet weak var employeeListButton: UIButton!
    @IBOutlet weak var addEmployeeButton: UIButton!
    @IBOutlet weak var totalEmployeeLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var foundationLabel: UILabel!
    var budget = 1000000.0
    var totalSalary = 0.0
    var totalEmployee = 0
    var companyName = "Vakıfbank"
    var foundationDate = 1954
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = companyName
        foundationLabel.text = "Foundation Year : \(foundationDate)"
        configureButtons()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        totalEmployee = Company.shared.allEmployee().count
        totalEmployeeLabel.text = "Total Employee : \(totalEmployee)"
        
    }
    
    func configureButtons(){
        let radiusValue : CGFloat = 15
        employeeListButton.layer.cornerRadius = radiusValue
        employeeListButton.layer.masksToBounds = true
        
        addEmployeeButton.layer.cornerRadius = radiusValue
        addEmployeeButton.layer.masksToBounds = true
        
        paySalaryButton.layer.cornerRadius = radiusValue
        paySalaryButton.layer.masksToBounds = true
    }

    @IBAction func payEmployeeSalary(_ sender: UIButton) {
        totalSalary = Company.shared.payEmployeeSalary()
        if budget < totalSalary {
            showAlert(title: "Error", messages: "Unfortunately we are not paying the salary")
        } else {
            budget -= totalSalary
            showAlert(title: "Salary Alert :)", messages: "We have \(totalEmployee) and total salary is : \(totalSalary)")
            budgetLabel.text = "Budget : \(budget)"
        }
        
    }
    @IBAction func transactions(_ sender: UIButton) {
        if sender.titleLabel?.text == "+" {
            guard let income = Double(incomeTextField.text ?? "0.0") else { return }
            budget += income
            showAlert(title: "We are getting rich :)", messages: "You added \(income)")
            budgetLabel.text = "Budget : \(budget)"
            
        } else {
            guard let expense = Double(expenseTextField.text ?? "0.0") else { return }
            
            if budget > expense {
                budget -= expense
                showAlert(title: "Expense Alert :)", messages: "Budget has been \(expense) damaged")
                budgetLabel.text = "Budget : \(budget)"
            } else {
                showAlert(title: "Error", messages: "Insufficient Budget")
            }
            
            
        }
    }
    
    @IBAction func employeeButton(_ sender: UIButton) {
        if sender.titleLabel?.text! == "Employee List" {
            performSegue(withIdentifier: "employeeList", sender: nil)
        } else {
            performSegue(withIdentifier: "addEmployee", sender: nil)
            
        }
    }
    
    func showAlert(title:String,messages:String){
            let alert = UIAlertController(title: title, message: messages, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        }
    
}

