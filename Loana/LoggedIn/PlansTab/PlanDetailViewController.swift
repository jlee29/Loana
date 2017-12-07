//
//  PlanDetailViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

protocol PlanDetailViewControllerDelegate {
    func updatedPlan(_ plan: String)
}

class PlanDetailViewController: UIViewController {
    
    var delegate: PlanDetailViewControllerDelegate?
    
    func confirmationHandler(alert: UIAlertAction!) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var useButton: UIButton!
    
    @IBOutlet weak var graphImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalMonthLabel: UILabel!
    @IBOutlet weak var totalLoanCostLabel: UILabel!
    @IBOutlet weak var interestRateLabel: UILabel!
    @IBOutlet weak var principalOwedLabel: UILabel!
    @IBOutlet weak var adjustedGrossIncomeLabel: UILabel!
    
    @IBAction func setPlan(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirmation", message: "You've selected this plan!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: confirmationHandler))
        self.present(alert, animated: true, completion: nil)
        delegate?.updatedPlan(long2short(_: titleLabel.text!))
        //Change the amount owed at the end of the month
        var loan = totalLoanCostLabel.text!
        loan.remove(at: loan.startIndex)
        let newMonthPayment = Double(plan2AmountOwedPerMonth(plan: titleLabel.text!))
        var amountOwed = newMonthPayment - Session.shared.user.repayment_balance[Session.shared.currMonth][Session.shared.currDay]
        if amountOwed < 0.0{
            Session.shared.user.manual_pay_schedule[Session.shared.currMonth + 1].append((0,-1*amountOwed))
            amountOwed = 0.0
        }
        Session.shared.user.remaining_amount = amountOwed
        for i in Session.shared.currMonth...Session.shared.user.repayment_schedule.count-1{
            Session.shared.user.repayment_schedule[i] = newMonthPayment
        }
        update_installment()
        update_repayment_balance()
    }
    
    func update_repayment_balance(){
        let interval = get_interval_in_days()
        let last_index = Session.shared.user.auto_pay_schedule[Session.shared.currMonth].count - 1
        
        if Session.shared.user.intervalPlan == "Monthly"{
            for i in Session.shared.currDay...last_index{
                Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = 0
                if i == last_index{
                    Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = Session.shared.user.auto_pay_installment
                }
            }
            return
        }
        for i in stride(from: last_index, to: Session.shared.currDay, by: -1){
            Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = 0
            if (last_index - i) % interval != 0{
                continue
            }
            Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = Session.shared.user.auto_pay_installment
        }
    }
    
    func update_installment(){
        if Session.shared.user.intervalPlan == "Monthly"{
            Session.shared.user.auto_pay_installment = Session.shared.user.remaining_amount
            return
        }
        let interval = get_interval_in_days()
        let payment_days = get_num_payment_days(interval:interval)
        print(Session.shared.user.remaining_amount)
        print(payment_days)
        Session.shared.user.auto_pay_installment = Session.shared.user.remaining_amount / Double (payment_days)
        print(Session.shared.user.auto_pay_installment)
    }
    
    func get_interval_in_days()->Int{
        if Session.shared.user.intervalPlan == "Daily"{
            return 1
        } else if Session.shared.user.intervalPlan == "Weekly"{
            return 7
        } else if Session.shared.user.intervalPlan == "Biweekly"{
            return 14
        }
        return -1
    }
    
    func get_num_payment_days(interval: Int)->Int{
        let differences = Session.shared.user.auto_pay_schedule[Session.shared.currMonth].count - Session.shared.currDay - 1
        return differences / interval + 1
    }
    
    func long2short(_ titleText:String) -> String {
        if(titleText == "Income-Based Repayment"){
            return "IBR"
        }else if(titleText == "Income-Contingent Repayment"){
            return "ICR"
        }else if(titleText == "Pay As You Earn"){
            return "PAYE"
        }else if(titleText == "Standard"){
            return "Standard"
        }else if(titleText == "Graduated"){
            return "Graduated"
        }else{
            return "Extended"
        }
    }
    
    //These numbers are conveniently hard-coded to avoid edge cases.
    //Change these numbers when you change the actual plan numbers.
    func plan2AmountOwedPerMonth(plan: String)->Int{
        if(plan == "Income-Based Repayment"){
            return 500
        }else if(plan == "Income-Contingent Repayment"){
            return 500
        }else if(plan == "Pay As You Earn"){
            return 520
        }else if(plan == "Standard"){
            return 550
        }else if(plan == "Graduated"){
            return 550
        }else{
            return 550
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        adjustedGrossIncomeLabel.text = "$25,000"
        principalOwedLabel.text = "$20,000"
        interestRateLabel.text = "6.8%"
        totalLoanCostLabel.text = "$35,431"
        totalMonthLabel.text = "195"
        titleLabel.text = short2Long(_: testString!)
        useButton.layer.cornerRadius = 10
        if(testString == "IBR" || testString == "PAYE" || testString == "ICR" ){
            graphImage.image = UIImage(named: "IBR.png")
        } else if(testString == "Graduated" || testString == "Extended") {
            graphImage.image = UIImage(named: "graduated.png")
        } else {
            graphImage.image = UIImage(named: "standard.png")
        }
    }
    
    func short2Long(_ testString: String) -> String {
        if(testString == "IBR"){
            return "Income-Based Repayment"
        }else if(testString == "ICR"){
            return "Income-Contingent Repayment"
        }else if(testString == "PAYE"){
            return "Pay As You Earn"
        }else if(testString == "Standard"){
            return "Standard"
        }else if(testString == "Graduated"){
            return "Graduated"
        }
        return "Extended"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var testString: String?
    

}
