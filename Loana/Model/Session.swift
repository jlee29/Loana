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
        self.loggedIn = loggedIn
        self.user = User(name: "test name",
                         age: 35,
                         maritalStatus: "Single",
                         income: 1,
                         publicSector: true,
                         stateOfResidence: "California",
                         loanProvider: "Random",
                         loanID: "randomID",
                         id: "a1",
                         intervalPlan: "Monthly",
                         currPlan: "Standard")
    }
    var loggedIn: Bool
    var user: User
}
