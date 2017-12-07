//
//  User.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import Foundation

struct User {
    enum IntervalPlan {
        case daily
        case weekly
        case biweekly
        case monthly
    }
    
    var name: String
    var age: Int
    var maritalStatus: String
    var income: Int
    var publicSector: Bool
    var stateOfResidence: String
    var loanProvider: String
    var loanID: String
    var id: String
    var intervalPlan: IntervalPlan
    var repayment_balance: [[Double]] //
    var repayment_schedule: [Double] //
    var auto_pay_schedule: [[Double]] //
    var manual_pay_schedule: [[(Int,Double)]] //
    var auto_pay_installment: Double
    var remaining_amount: Double
    var currPlan: String
    var bankAccount: BankAccount
}
