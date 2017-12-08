//
//  Session.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import Foundation

class Session {
    static let shared = Session(loggedIn:true)
    init(loggedIn: Bool){
        self.currMonth = 1
        self.currDay = 7
        self.loggedIn = loggedIn
        
        self.user = User(
            name: "Peter Lu",
            age: 35,
            maritalStatus: "Single",
            income: 1,
            publicSector: true,
            stateOfResidence: "California",
            loanProvider: "Random",
            loanID:"randomID",
            id: "a1",
            intervalPlan: .weekly,
            repayment_balance: [Array(repeating: 200.0,count: 31),[0.0,0.0,0.0,0.0,0.0,0.0,50.0,50.0,50.0,50.0,50.0,50.0,50.0,100.0,100.0,100.0,100.0,100.0,100.0,100.0,150.0,150.0,15.0,150.0,150.0,150.0,150.0,200.0,200.0,200.0],
                                Array(repeating: 0.0,count: 31)],
            repayment_schedule: [200,200,200],
            auto_pay_schedule: [Array(repeating: 0.0,count:31),[0.0,0.0,0.0,0.0,0.0,0.0,50.0,0.0,0.0,0.0,0.0,0.0,0.0,50.0,0.0,0.0,0.0,0.0,0.0,0.0,50.0,0.0,0.0,0.0,0.0,0.0,0.0,50.0,0.0,0.0],
                                Array(repeating:0.0,count: 31)],
            manual_pay_schedule:[[(0,200.0)],[],[]],
            auto_pay_installment: 50.0,
            remaining_amount: 150.0,
            currPlan: "Standard",
            bankAccount: BankAccount(bankName: "Wells Fargo", accountName: "Peter Lu", number: "4578"))
    }
    var loggedIn: Bool
    var user: User
    var currMonth: Int
    var currDay: Int

}
    

