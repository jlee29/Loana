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
        self.currDay = 20
        self.loggedIn = loggedIn
        
        self.user = User(name: "test name",
            age: 35,
            maritalStatus: "Single",
            income: 1,
            publicSector: true,
            stateOfResidence: "California",
            loanProvider: "Random",
            loanID:"randomID",
            id: "a1",
            intervalPlan: "Monthly",
            repayment_balance: [Array(repeating: 350.0,count: 31),[0.0,150.0,150.0,150.0,150.0,150.0,150.0,275.0,275.0,275.0,275.0,275.0,275.0,275.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0],
                                Array(repeating: 0.0,count: 31)],
            repayment_schedule: [400,400,400],
            auto_pay_schedule: [Array(repeating: 0.0,count:31),[0.0,125.0,0.0,0.0,0.0,0.0,0.0,125.0,0.0,0.0,0.0,0.0,0.0,0.0,125.0,0.0,0.0,0.0,0.0,0.0,0.0,125.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],
                                Array(repeating:0.0,count: 31)],
            manual_pay_schedule:[[(0,350.0)],[(1,25)],[]],
            auto_pay_installment: 125,
            remaining_amount: 0.0,
            currPlan: "Standard")
    }
    var loggedIn: Bool
    var user: User
    var currMonth: Int
    var currDay: Int

}
    

