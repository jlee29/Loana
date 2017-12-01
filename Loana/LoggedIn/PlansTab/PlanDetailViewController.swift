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

    @IBOutlet weak var principalOwedLabel: UILabel!
    @IBOutlet weak var annualAdjustedGrossIncomeLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    
    func confirmationHandler(alert: UIAlertAction!) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func setPlan(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirmation", message: "You've selected this plan!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: confirmationHandler))
        self.present(alert, animated: true, completion: nil)
        delegate?.updatedPlan(testLabel.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        if(testString == "IBR"){
            testLabel.text = "Income-Based Repayment"
        }else if(testString == "ICR"){
            testLabel.text = "Income-Contingent Repayment"
        }else if(testString == "PAYE"){
            testLabel.text = "Pay As You Earn"
        }else if(testString == "Standard"){
            testLabel.text = "Standard"
        }else if(testString == "Graduated"){
            testLabel.text = "Graduated"
        }else{
            testLabel.text = "Extended"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var testString: String?
    

}
