//
//  LoanFinder.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import Foundation

struct LoanFinder {
    func findLoan() -> Loan {
        let loan = Loan(planID: 1, principal: 1.0, rate: 1.0, amountLeft: 1.0)
        return loan
    }
}
