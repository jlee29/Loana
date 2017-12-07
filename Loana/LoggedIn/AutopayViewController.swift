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
        util.update_installment()
        util.update_repayment_balance()
        
        print(Session.shared.user.auto_pay_schedule[Session.shared.currMonth])
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
    
//    func update_repayment_balance(){
//
//        let interval = get_interval_in_days()
//        let last_index = Session.shared.user.auto_pay_schedule[Session.shared.currMonth].count - 1
//
//        if Session.shared.user.intervalPlan == "Monthly"{
//            for i in Session.shared.currDay...last_index{
//                Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = 0
//                if i == last_index{
//                    Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = Session.shared.user.auto_pay_installment
//                }
//            }
//            return
//        }
//        for i in stride(from: last_index, to: Session.shared.currDay, by: -1){
//            Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = 0
//            if (last_index - i) % interval != 0{
//                continue
//            }
//            Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = Session.shared.user.auto_pay_installment
//        }
//    }
//
//    func update_installment(){
//        if Session.shared.user.intervalPlan == "Monthly"{
//            Session.shared.user.auto_pay_installment = Session.shared.user.remaining_amount
//        }
//
//        let interval = get_interval_in_days()
//        let payment_days = get_num_payment_days(interval:interval)
//
//        print(Session.shared.user.remaining_amount)
//        print(payment_days)
//
//        Session.shared.user.auto_pay_installment = Session.shared.user.remaining_amount / Double (payment_days)
//        print(Session.shared.user.auto_pay_installment)
//    }
//
//    func get_interval_in_days()->Int{
//        if Session.shared.user.intervalPlan == "Daily"{
//            return 1
//        } else if Session.shared.user.intervalPlan == "Weekly"{
//            return 7
//        } else if Session.shared.user.intervalPlan == "Biweekly"{
//            return 14
//        }
//        return -1
//    }
//
//    func get_num_payment_days(interval: Int)->Int{
//        let differences = Session.shared.user.auto_pay_schedule[Session.shared.currMonth].count - Session.shared.currDay - 1
//        return differences / interval + 1
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
