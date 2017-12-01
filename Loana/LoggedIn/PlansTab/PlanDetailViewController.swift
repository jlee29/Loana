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
