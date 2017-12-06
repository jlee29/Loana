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
        self.user = User(name: "test name",age: 35,income: 1,publicSector: true,id: "a1",repayment_balance: [Array(repeating: 350.0,count: 31),[0.0,150.0,150.0,150.0,150.0,150.0,150.0,275.0,275.0,275.0,275.0,275.0,275.0,275.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0,400.0],Array(repeating: 0.0,count: 31)],repayment_schedule: [425,425,425],auto_pay_schedule: [Array(repeating: 0.0,count:31),[0.0,150.0,0.0,0.0,0.0,0.0,0.0,125.0,0.0,0.0,0.0,0.0,0.0,0.0,125.0,0.0,0.0,0.0,0.0,0.0,0.0,125.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],Array(repeating:0.0,count: 31)],currPlan: "Standard")
    }
    var loggedIn: Bool
    var user: User
    var currMonth: Int
    var currDay: Int
}
