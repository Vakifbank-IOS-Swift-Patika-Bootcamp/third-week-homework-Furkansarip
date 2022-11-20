//
//  AddAnimalViewController.swift
//  ZooApp
//
//  Created by Furkan Sarı on 20.11.2022.
//

import UIKit

class AddAnimalViewController: UIViewController {

    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var keeperTextField: UITextField!
    @IBOutlet weak var animalTypeTextField: UITextField!
    let picker = UIPickerView()
    let picker2 = UIPickerView()
    var waterConsumption = 0
    var animalTypeArray = ["Frog","Cat","Bird","Coyote","Cow"]
    var keeperArray = [Keeper]()
    var keeper : Keeper?
    override func viewDidLoad() {
        super.viewDidLoad()
        waterLabel.text = "Water Consumption : \(waterConsumption)" //Seçili hayvana göre su tüketimi hesaplanıp yazdırılıyor.
        animalTypeTextField.inputView = picker // Hayvan tipi seçimlerini picker'a atadım.
        keeperTextField.inputView = picker2 // Çalışan listemizdekileri listeyelip
        picker.dataSource = self
        picker.delegate = self
        picker2.delegate = self
        picker2.dataSource = self
        keeperArray = Zoo.shared.allKeeperList()
        createToolbar()
    }
    
    func createToolbar(){
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
            toolbar.setItems([doneButton], animated: false)
                
            toolbar.isUserInteractionEnabled = true
            animalTypeTextField.inputAccessoryView = toolbar
            keeperTextField.inputAccessoryView = toolbar
            
        }
        
        @objc func dismissPicker() {
            view.endEditing(true)
        }
    

    @IBAction func addAnimal(_ sender: Any) {
        if nameTextField.text == "" || keeperTextField.text == "" || animalTypeTextField.text == "" {
            showAlert(title: "Empty Value", messages: "Empty TextField detected!")
        }
        else if keeper == nil {
            showAlert(title: "Keeper Error", messages: "You need a choose keeper!")
        }
        else {
            let animal = Animal(name: nameTextField.text!, waterConsumption: waterConsumption, keeper: keeper!, animalType: animalTypeTextField.text!)
            Zoo.shared.addAnimal(animal: animal)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
}

extension AddAnimalViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker {
            return animalTypeArray.count
        } else {
            return keeperArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker {
            return animalTypeArray[row]
        } else {
            return keeperArray[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker {
            animalTypeTextField.text = animalTypeArray[row]
            let type = animalTypeTextField.text
            switch type {
            case "Lion":
                waterConsumption = 16
                waterLabel.text = "Water Consumption : \(waterConsumption)L"
            case "Cow":
                waterConsumption = 14
                waterLabel.text = "Water Consumption : \(waterConsumption)L"
            case "Monkey":
                waterConsumption = 12
                waterLabel.text = "Water Consumption : \(waterConsumption)L"
            case "Bull":
                waterConsumption = 10
                waterLabel.text = "Water Consumption : \(waterConsumption)L"
            case "Tiger":
                waterConsumption = 14
                waterLabel.text = "Water Consumption : \(waterConsumption)L"
            default:
                waterConsumption = 5
                waterLabel.text = "Water Consumption : \(waterConsumption)L"
            }
            
        } else {
            keeperTextField.text = keeperArray[row].name
            keeper = keeperArray[row]
        }
    }
    
    func showAlert(title:String,messages:String){
        
        let alert = UIAlertController(title: title, message: messages, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
