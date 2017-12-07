//
//  ManualPayController.swift
//  Loana
//
//  Created by Miguel Ayala on 12/7/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import Foundation

import UIKit

class ManualPayController: UIViewController{
    
    @IBOutlet weak var manualPayAmount: UITextField!

    @IBAction func manualPayButton(_ sender: UIButton) {
        
        var user_amount = Double(manualPayAmount.text!)
        
    Session.shared.user.manual_pay_schedule[Session.shared.currMonth].append((Session.shared.currDay,user_amount!))
        
        Session.shared.user.repayment_balance[Session.shared.currMonth][Session.shared.currDay] += user_amount!
        
        //update remaining amount
        // update auto pay installment
        // update auto pay schedule
        
        
        
    }
    
    
}
