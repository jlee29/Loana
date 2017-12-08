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
        self.currMonthLongTerm = 60
        
        self.user = User(
            name: "Peter Lu",
            age: 25,
            maritalStatus: "Single",
            income: 15000,
            publicSector: true,
            stateOfResidence: "California",
            loanProvider: "Cornerstone",
            loanID:"0172314",
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
            repaymentHistory: Array(repeating: 0.0,count: 60),
            projectedRepaymentPlan: Array(repeating: 0.0,count: 240),
            bankAccount: BankAccount(bankName: "Wells Fargo", accountName: "Peter Lu's Checking", number: "xxx4578"))
        setPaidHistory()
        self.user.projectedRepaymentPlan = getProjectedRepaymentPlan(plan: self.user.currPlan)
    }
    
    func setPaidHistory(){
        var result = Array(repeating: 0.0,count: 60)
        var amount = 0.0
        for i in 0...result.count - 1{
            amount = amount + 200.0
            result[i] = amount
        }
        self.user.repaymentHistory = result
    }
    
    func getProjectedRepaymentPlan(plan: String)->[Double]{
        if(plan == "Income-Based Repayment" || plan == "IBR"){
            return getIncomeBasedRepayment()
        }else if(plan == "Income-Contingent Repayment" || plan == "ICR"){
            return getIncomeBasedRepayment()
        }else if(plan == "Pay As You Earn" || plan == "PAYE"){
            return getPayAsYouEarnRepayment()
        }else if(plan == "Standard"){
            return getStandardRepayment()
        }else if(plan == "Graduated"){
            return getGraduatedRepayment()
        }else{
            return getGraduatedRepayment()
        }
    }
    var loggedIn: Bool
    var user: User
    var currMonth: Int
    var currDay: Int
    var currMonthLongTerm: Int
    
    func getGraduatedRepayment()->[Double]{
        var result = Array(repeating: 0.0,count: 240)
        let finalAmount = 31000.0
        let loanIncreasePercentage = 1.01
        let base = 12000.0
        var monthlyPayment = 100.0
        for i in 0...result.count - 1{
            monthlyPayment = monthlyPayment * loanIncreasePercentage
            if i==0{
                result[i] = base + monthlyPayment
            }else{
                if result[i-1] >= finalAmount{
                    result[i] = result[i-1]
                }else{
                    result[i] = result[i-1] + monthlyPayment
                }
            }
        }
        return result
    }
    
    func getStandardRepayment()->[Double]{
        var result = Array(repeating: 0.0,count: 240)
        let finalAmount = 27619.0
        let monthlyPayment = 200.0
        let base = 12000.0
        for i in 0...result.count - 1{
            if i==0{
                result[i] = base + monthlyPayment
            }else{
                if result[i-1] >= finalAmount{
                    result[i] = result[i-1]
                }else{
                    result[i] = result[i-1] + monthlyPayment
                }
            }
        }
        return result 
    }
    
    func getPayAsYouEarnRepayment()->[Double]{
        var income = Double(self.user.income)
        let annualIncomeIncrease = 1.05
        let percentageOfIncomePaid = 0.10
        let finalAmount = 27414.0
        let base = 12000.0
        var result = Array(repeating: 0.0,count: 240)
        for i in 0...result.count - 1{
            if i % 12 == 0{
                income = annualIncomeIncrease*income
            }
            let monthlyPayment = (percentageOfIncomePaid * income)/12.0
            if i==0{
                result[i] = base + monthlyPayment
            }else{
                if result[i-1] >= finalAmount{
                    result[i] = result[i-1]
                }else{
                    result[i] = result[i-1] + monthlyPayment
                }
            }
        }
        return result
    }
    
    func getIncomeBasedRepayment()->[Double]{
        var income = Double(self.user.income)
        let annualIncomeIncrease = 1.05
        let percentageOfIncomePaid = 0.10
        let finalAmount = 22877.0
        let base = 12000.0
        var result = Array(repeating: 0.0,count: 240)
        for i in 0...result.count - 1{
            if i % 12 == 0{
                income = annualIncomeIncrease*income
            }
            let monthlyPayment = (percentageOfIncomePaid * income)/12.0
            if i==0{
                result[i] = base + monthlyPayment
            }else{
                if result[i-1] >= finalAmount{
                    result[i] = result[i-1]
                }else{
                    result[i] = result[i-1] + monthlyPayment
                }
            }
        }
        return result
    }
    
    //hard coded amounts courtesy of Jaime
    func getTotalLoanCost(plan: String)->Double{
        if(plan == "Income-Based Repayment" || plan == "IBR"){
            return 22877.0
        }else if(plan == "Income-Contingent Repayment" || plan == "ICR"){
            return 22877.0
        }else if(plan == "Pay As You Earn" || plan=="PAYE"){
            return 27414.0
        }else if(plan == "Standard"){
            return 27619.0
        }else if(plan == "Graduated"){
            return 31000
        }else{
            return 31000
        }
    }
    
    func getMonthsLeft(plan: String)->Int{
        let total = getTotalLoanCost(plan: plan)
        let arr = getProjectedRepaymentPlan(plan: plan)
        
        for i in 0...arr.count - 1{
            if arr[i] >= total{
                return i
            }
        }
        return -1
    }

}
    

