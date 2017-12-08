//
//  PlanDetailViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit
import Charts

protocol PlanDetailViewControllerDelegate {
    func updatedPlan(_ plan: String)
}

class PlanDetailViewController: UIViewController {
    
    @IBOutlet weak var planDetailChart: LineChartView!
    
    var util = Util()
    
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
    @IBOutlet weak var adjustedGrossIncomeLabel: UILabel!
    
    @IBOutlet weak var amountPaidLabel: UILabel!
    @IBAction func setPlan(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirmation", message: "You've selected this plan!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: confirmationHandler))
        self.present(alert, animated: true, completion: nil)
        delegate?.updatedPlan(long2short(_: titleLabel.text!))
        //Change the amount owed at the end of the month
        var loan = totalLoanCostLabel.text!
        loan.remove(at: loan.startIndex)
        let newMonthPayment = plan2AmountOwedPerMonth(plan: titleLabel.text!)
        var amountOwed = newMonthPayment - Session.shared.user.repayment_balance[Session.shared.currMonth][Session.shared.currDay]
        if amountOwed < 0.0{
            Session.shared.user.manual_pay_schedule[Session.shared.currMonth + 1].append((0,-1*amountOwed))
            amountOwed = 0.0
        }
        Session.shared.user.remaining_amount = amountOwed
        for i in Session.shared.currMonth...Session.shared.user.repayment_schedule.count-1{
            Session.shared.user.repayment_schedule[i] = newMonthPayment
        }
        util.update_installment()
        util.update_repayment_balance()
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
    
    //These numbers are conveniently hard-coded to avoid edge cases. - not anymore u fucker
    //Change these numbers when you change the actual plan numbers. - idid
    func plan2AmountOwedPerMonth(plan: String)->Double{
        let last_payment = Session.shared.user.repaymentHistory[Session.shared.user.repaymentHistory.count - 1]
        if(plan == "Income-Based Repayment"){
            return Session.shared.getIncomeBasedRepayment()[0] - last_payment
        }else if(plan == "Income-Contingent Repayment"){
            return Session.shared.getIncomeBasedRepayment()[0] - last_payment
        }else if(plan == "Pay As You Earn"){
            return Session.shared.getPayAsYouEarnRepayment()[0] - last_payment
        }else if(plan == "Standard"){
            return Session.shared.getStandardRepayment()[0] - last_payment
        }else if(plan == "Graduated" || plan == "Extended"){
            return Session.shared.getGraduatedRepayment()[0] - last_payment
        }else{
            return Session.shared.getGraduatedRepayment()[0] - last_payment
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adjustedGrossIncomeLabel.text = util.doubleToDollar(num1: Double(Session.shared.user.income))
        amountPaidLabel.text = util.doubleToDollar(num1: Session.shared.user.repaymentHistory[Session.shared.user.repaymentHistory.count - 1])
        interestRateLabel.text = util.doubleToDollar(num1: plan2AmountOwedPerMonth(plan: short2Long(testString!))) //actually next contribition
        totalLoanCostLabel.text = util.doubleToDollar(num1: Session.shared.getTotalLoanCost(plan:  short2Long(testString!)) - Session.shared.user.repaymentHistory[Session.shared.user.repaymentHistory.count - 1])
        totalMonthLabel.text = String(Session.shared.getMonthsLeft(plan:  short2Long(testString!)))
        titleLabel.text = short2Long(_:  testString!)
        useButton.layer.cornerRadius = 10
        //        if(testString == "IBR" || testString == "PAYE" || testString == "ICR" ){
        //            graphImage.image = UIImage(named: "IBR.png")
        //        } else if(testString == "Graduated" || testString == "Extended") {
        //            graphImage.image = UIImage(named: "graduated.png")
        //        } else {
        //            graphImage.image = UIImage(named: "standard.png")
        //        }
        
        var planTitle = ""
        if testString == "IBR"{
            planTitle = short2Long("IBR")
        } else if testString == "ICR"{
            planTitle = short2Long("ICR")
        } else if testString == "PAYE"{
            planTitle = short2Long("PAYE")
        }else if testString == "Standard"{
            planTitle = short2Long("Standard")
        }else if testString == "Graduated"{
            planTitle = short2Long("Graduated")
        }
        
        let pastSchedule = Session.shared.user.repaymentHistory
        let past = RepaymentPlan(title: "Repayment History",schedule: pastSchedule)
        
        let longTermSchedule = Session.shared.getProjectedRepaymentPlan(plan: planTitle)
        let planArr = [RepaymentPlan(title: planTitle, schedule:longTermSchedule)]
        
        util.update_graph(chart: planDetailChart, curr_plan: past, alt_plans: planArr)
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
