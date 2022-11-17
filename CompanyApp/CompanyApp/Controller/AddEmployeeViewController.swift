//
//  AddEmployeeViewController.swift
//  CompanyApp
//
//  Created by Furkan Sarı on 14.11.2022.
//

import UIKit

class AddEmployeeViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var employeeTypeField: UITextField!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    var salary = 5500.0 //Standard Salary 
    let employeeTypeList = ["Accountant","Human Resources","Developer","Lead","Manager"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let picker = UIPickerView()
        employeeTypeField.inputView = picker
        addButton.layer.cornerRadius = 20
        addButton.layer.masksToBounds = true
        picker.delegate = self
        picker.dataSource = self
        createToolbar()
        
     
    }
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: false)
            
        toolbar.isUserInteractionEnabled = true
        employeeTypeField.inputAccessoryView = toolbar
        
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    
    @IBAction func addEmployee(_ sender: UIButton) {
    let employee = Employee(name: fullNameTextField.text!, age: ageTextField.text!,salary: salary)
        Company.shared.addEmployee(employee: employee)
        navigationController?.popViewController(animated: true)
    }
    
}




extension AddEmployeeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        employeeTypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return employeeTypeList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        employeeTypeField.text = employeeTypeList[row]
        let type = employeeTypeField.text
        switch type {
        case "Accountant":
            salary = 5500.0
            salary = salary * 3
            salaryLabel.text = String(salary) + "TL"
        case "Human Resources":
            salary = 5500.0
            salary = salary * 3
            salaryLabel.text = String(salary) + "TL"
        case "Developer":
            salary = 5500.0
            salary = salary * 4
            salaryLabel.text = String(salary) + "TL"
        case "Lead":
            salary = 5500.0
            salary = salary * 6
            salaryLabel.text = String(salary) + "TL"
        case "Manager":
            salary = 5500.0
            salary = salary * 8
            salaryLabel.text = String(salary) + "TL"
        default:
            salary = 5500.0
            salary = salary * 2
            salaryLabel.text = String(salary) + "TL"
        }
    }
    
    
}
