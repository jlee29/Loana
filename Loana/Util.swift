//
//  Util.swift
//  Loana
//
//  Created by Miguel Ayala on 12/7/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import Foundation

class Util {
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
    
    func remaining_month(){
        Session.shared.user.remaining_amount =  Session.shared.user.repayment_schedule[Session.shared.currMonth] - Session.shared.user.repayment_balance[Session.shared.currMonth][Session.shared.currDay]
    }
}
