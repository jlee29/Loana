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
    
    var user = Session.shared.user
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planPickerData = ["Daily", "Weekly", "Biweekly", "Monthly"]
        self.planPicker.delegate = self
        self.planPicker.dataSource = self
        currentPlanLabel.text = "Your current plan is: " + Session.shared.user.intervalPlan
        for (index, element) in planPickerData.enumerated() {
            if element == Session.shared.user.intervalPlan{
                planPicker.selectRow(index, inComponent: 0, animated: false)
                break
            }
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func onSaveButtonClick(_ sender: UIButton) {
        Session.shared.user.intervalPlan = planPickerData[planPicker.selectedRow(inComponent: 0)]
        currentPlanLabel.text = "Your current plan is: " + planPickerData[planPicker.selectedRow(inComponent: 0)]
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
    
    func update_repayment_balance(){
        return
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
