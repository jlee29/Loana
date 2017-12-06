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
    var income: Int
    var publicSector: Bool

    var id: String
    
    var repayment_balance: [[Double]] //
    var repayment_schedule: [Double] //
    var auto_pay_schedule: [[Double]] //
    
    var currPlan: String
}
