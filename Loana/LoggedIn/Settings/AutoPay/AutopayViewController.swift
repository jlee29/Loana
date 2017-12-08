//
//  AutopayViewController.swift
//  Loana
//
//  Created by Jaime Deverall on 06/12/2017.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class AutopayViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    var planPickerData: [String] = [String]()

    var util = Util()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planPickerData = ["Daily", "Weekly", "Biweekly", "Monthly"]
        self.planPicker.delegate = self
        self.planPicker.dataSource = self
        let enumStr = util.intervalEnumToString(interval: Session.shared.user.intervalPlan)
        
        saveButton.layer.cornerRadius = 22
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.darkGray.cgColor
        
        currentPlanLabel.font = UIFont(name: "Avenir", size: 30)
        currentPlanLabel.text = "Your current plan is: \(enumStr)"
        for (index, element) in planPickerData.enumerated() {
            if element == enumStr {
                planPicker.selectRow(index, inComponent: 0, animated: false)
                break
            }
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func onSaveButtonClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Confirmation", message: "Change Pay Interval to \(self.planPickerData[self.planPicker.selectedRow(inComponent: 0)])?", preferredStyle: .alert)
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            Session.shared.user.intervalPlan = self.util.intervalStringToEnum(interval: self.planPickerData[self.planPicker.selectedRow(inComponent: 0)])
            self.currentPlanLabel.text = "Your current plan is: " + self.planPickerData[self.planPicker.selectedRow(inComponent: 0)]
            self.util.update_installment()
            self.util.update_repayment_balance()
            
            print(Session.shared.user.auto_pay_schedule[Session.shared.currMonth])
            
        }
        alertController.addAction(OKAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        
        // Present Dialog message
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var planPicker: UIPickerView!
    @IBOutlet weak var currentPlanLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return planPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return planPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: planPickerData[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
