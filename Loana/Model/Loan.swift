//
//  Loan.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import Foundation

struct Loan {
    var planID: Int
    var principal: Double
    var rate: Double
    var amountLeft: Double
    init(planID: Int, principal: Double, rate: Double, amountLeft: Double) {
        self.planID = planID
        self.principal = principal
        self.rate = rate
        self.amountLeft = amountLeft
    }
}
