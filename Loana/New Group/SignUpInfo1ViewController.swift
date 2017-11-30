//
//  LoginViewController.swift
//  Loana
//
//  Created by Miguel Ayala on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class SignUpInfo1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Properties

    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var maritalStatusPicker: UIPickerView!
    var maritalStatusPickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        maritalStatusPickerData = ["Married", "Single"]
        self.maritalStatusPicker.delegate = self
        self.maritalStatusPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView == maritalStatusPicker){
            return 1
        }
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == maritalStatusPicker){
            return maritalStatusPickerData.count
        }
        return 1
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == maritalStatusPicker){
            return maritalStatusPickerData[row]
        }
        return "Hi"
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     */
    
}


