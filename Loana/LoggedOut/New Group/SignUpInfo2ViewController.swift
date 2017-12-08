//
//  SignUpInfo2ViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/30/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class SignUpInfo2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var loanProviderPicker: UIPickerView!
    @IBOutlet weak var loanIDTextField: UITextField!
    
    @IBOutlet weak var connectLoanButton: UIButton!
    
    var loanProviderPickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loanProviderPickerData = ["CornerStone", "FedLoan Servicing (PHEAA)", "Granite State – GSMR",
        "Great Lakes Educational Loan Services, Inc.", "HESC/Edfinancial", "MOHELA", "Navient",
        "Nelnet", "OSLA Servicing"]
        self.loanProviderPicker.delegate = self
        self.loanProviderPicker.dataSource = self
        loanIDTextField.delegate = self
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        connectLoanButton.layer.cornerRadius = 22
        connectLoanButton.layer.borderWidth = 1
        connectLoanButton.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // needed to clear the text in the back navigation:
        self.navigationItem.title = " "
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        loanIDTextField.resignFirstResponder()
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
        return loanProviderPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return loanProviderPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: loanProviderPickerData[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Session.shared.user.loanID = loanIDTextField.text!
        Session.shared.user.loanProvider = loanProviderPickerData[loanProviderPicker.selectedRow(inComponent: 0)]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }

}
