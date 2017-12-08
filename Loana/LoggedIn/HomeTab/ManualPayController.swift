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
    
    var util = Util()
    
    @IBOutlet weak var manualPayAmount: UITextField!
    
    func addedCorrectly() {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Deposited Successfully!", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.navigationController?.dismiss(animated: true, completion: nil)
        })
        
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func printError() {
        let inputAlert = UIAlertController(title: "Input Error", message: "Enter a valid amount", preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        inputAlert.addAction(okAction)
        self.present(inputAlert, animated: true, completion:nil)
    }

    @IBAction func manualPayButton(_ sender: UIButton) {
        if let unwrap = manualPayAmount.text, unwrap != "" {
            var isValidCurrencyFormat = false
            
            let numberParts = unwrap.components(separatedBy: ".")
            if numberParts.count == 2 {
                let decimalArray = Array(numberParts[1])
                if decimalArray.count <= 2 {
                    if unwrap == unwrap.trimmingCharacters(in: .whitespacesAndNewlines) {
                        isValidCurrencyFormat = true
                    }
                }
            } else {
                if unwrap == unwrap.trimmingCharacters(in: .whitespacesAndNewlines) {
                    isValidCurrencyFormat = true
                }
            }
            
            if isValidCurrencyFormat {
                var user_amount = Double(unwrap)!
                
                let msg = "Charge $" + unwrap + " to account ending in " + Session.shared.user.bankAccount.number
                
                let paymentAlert = UIAlertController(title: "Confirm Payment", message: msg, preferredStyle: .alert)
                let ConfirmAction = UIAlertAction(title: "Confirm", style: .default) { (action:UIAlertAction!) in
                    Session.shared.user.manual_pay_schedule[Session.shared.currMonth].append((Session.shared.currDay,user_amount))
                    
                    let excess = user_amount - Session.shared.user.remaining_amount
                    
                    if excess < 0.0 {
                        user_amount -= excess
                        Session.shared.user.manual_pay_schedule[Session.shared.currMonth + 1].append((0,excess))
                    }
                    
                    Session.shared.user.repayment_balance[Session.shared.currMonth][Session.shared.currDay] += user_amount
                    
                    self.util.remaining_month()
                    self.util.update_installment()
                    self.util.update_repayment_balance()
                }
                
                paymentAlert.addAction(ConfirmAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                    return
                }
                paymentAlert.addAction(cancelAction)
                self.present(paymentAlert, animated: true, completion:nil)
            } else {
                printError()
            }
        } else {
            printError()
        }
    }
        
    
    
    
}
