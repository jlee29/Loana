//
//  LoginViewController.swift
//  Loana
//
//  Created by Miguel Ayala on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class SignUpInfo1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    //MARK: - Properties

    @IBOutlet weak var publicSectorPicker: UIPickerView!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var maritalStatusPicker: UIPickerView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var maritalStatusPickerData: [String] = [String]()
    var publicSectorPickerData: [String] = [String]()
    var statePickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 22
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.darkGray.cgColor
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        maritalStatusPickerData = ["Married", "Single"]
        publicSectorPickerData = ["Yes", "No"]
        statePickerData = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
            "Maine", "Maryland", "Massachusetts", "Michigan",
            "Minnesota", "Mississippi", "Missouri", "Montana",
            "Nebraska", "Nevada", "New Hampshire", "New Jersey",
            "New Mexico", "New York", "North Carolina",
            "North Dakota", "Ohio", "Oklahoma", "Oregon",
            "Pennsylvania", "Rhode Island", "South Carolina",
            "South Dakota", "Tennessee", "Texas", "Utah",
            "Vermont", "Virginia", "Washington", "West Virginia",
            "Wisconsin", "Wyoming"]
        self.maritalStatusPicker.delegate = self
        self.maritalStatusPicker.dataSource = self
        self.publicSectorPicker.delegate = self
        self.publicSectorPicker.dataSource = self
        self.statePicker.delegate = self
        self.statePicker.dataSource = self
        self.incomeTextField.delegate = self
        self.nameTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // needed to clear the text in the back navigation:
        self.navigationItem.title = " "
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        incomeTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == maritalStatusPicker){
            return maritalStatusPickerData.count
        }else if(pickerView == publicSectorPicker){
            return publicSectorPickerData.count
        }
        return statePickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == maritalStatusPicker){
            return maritalStatusPickerData[row]
        }else if(pickerView == publicSectorPicker){
            return publicSectorPickerData[row]
        }
        return statePickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == publicSectorPicker {
            return NSAttributedString(string: publicSectorPickerData[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        } else if pickerView == statePicker {
            return NSAttributedString(string: statePickerData[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        } else {
            return NSAttributedString(string: maritalStatusPickerData[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func printError() {
        let inputAlert = UIAlertController(title: "Input Error", message: "Enter a valid income!", preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        inputAlert.addAction(okAction)
        self.present(inputAlert, animated: true, completion:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Session.shared.user.name = nameTextField.text!
        if let income = incomeTextField.text, income != "" {
            Session.shared.user.income = Int(income)!
            Session.shared.user.maritalStatus = maritalStatusPickerData[maritalStatusPicker.selectedRow(inComponent: 0)]
            Session.shared.user.publicSector = Bool(responseToBool(in: publicSectorPickerData[publicSectorPicker.selectedRow(inComponent: 0)]))
            Session.shared.user.stateOfResidence = statePickerData[statePicker.selectedRow(inComponent: 0)]
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        } else {
            printError()
        }
    }
    
    func responseToBool(in response: String) -> Bool {
        if response == "Yes"{
            return true
        }
        return false
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     */
    
}


