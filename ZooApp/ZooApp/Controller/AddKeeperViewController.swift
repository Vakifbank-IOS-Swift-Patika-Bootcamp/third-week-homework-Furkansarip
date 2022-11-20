//
//  AddKeeperViewController.swift
//  ZooApp
//
//  Created by Furkan Sarı on 20.11.2022.
//

import UIKit

class AddKeeperViewController: UIViewController {

    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var salaryLabel: UILabel!
    private var experienceArray = ["Intern","Rookie","Mid","Expert"]
    private var salary = 5500.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let picker = UIPickerView()
        experienceTextField.inputView = picker
        picker.dataSource = self
        picker.delegate = self
        createToolbar()
        // Do any additional setup after loading the view.
    }
    
    func createToolbar(){//UIpicker view için done butonu ve bazı ayarlar.
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
            toolbar.setItems([doneButton], animated: false)
                
            toolbar.isUserInteractionEnabled = true
            experienceTextField.inputAccessoryView = toolbar
            
        }
        
        @objc func dismissPicker() {
            view.endEditing(true)
        }
    
    @IBAction func addKeeperButton(_ sender: Any) {
        
        if fullNameTextField.text == "" || ageTextField.text == "" || experienceTextField.text == "" {//Textfield.isempty kontrolü
            showAlert(title: "Empty Value", messages: "Empty TextField detected!")
        } else {//Gerekli kontroller sonrası keeper oluşturuldu ve hayvanat bahçesine eklendi.
            let keeper = Keeper(name: fullNameTextField.text!, experience: experienceTextField.text!, age: ageTextField.text!,salary: salary)
            Zoo.shared.addKeeper(keeper: keeper)
            print(keeper)
            navigationController?.popViewController(animated: true)
        }
        
    }
    func showAlert(title:String,messages:String){
                let alert = UIAlertController(title: title, message: messages, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            }
    
   
}

extension AddKeeperViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        experienceArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return experienceArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {//Seçilen Tecrübeye göre maaş hesaplanıyor.
        experienceTextField.text = experienceArray[row]
        let exp = experienceTextField.text
        switch exp {
        case "Intern":
            salary = 5500
            salary = salary * 1
            salaryLabel.text = "\(salary) TL"
        case "Rookie":
            salary = 5500
            salary = salary * 2
            salaryLabel.text = "\(salary) TL"
        case "Mid":
            salary = 5500
            salary = salary * 3
            salaryLabel.text = "\(salary) TL"
        case "Expert":
            salary = 5500
            salary = salary * 4
            salaryLabel.text = "\(salary) TL"
        default:
            salary = 5500
            salaryLabel.text = "\(salary) TL"
        }
    }
    
    
}
