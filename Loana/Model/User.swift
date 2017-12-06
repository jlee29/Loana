//
//  User.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import Foundation

struct User {
    var name: String
    var age: Int
    var maritalStatus: String
    var income: Int
    var publicSector: Bool
    var stateOfResidence: String
    var loanProvider: String
    var loanID: String
    var id: String
    var intervalPlan: String
    var repayment_balance: [[Double]] //
    var repayment_schedule: [Double] //
    var auto_pay_schedule: [[Double]] //
    var currPlan: String
}
