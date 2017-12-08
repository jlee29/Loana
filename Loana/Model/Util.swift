//
//  Util.swift
//  Loana
//
//  Created by Miguel Ayala on 12/7/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import Foundation
import Charts

class Util {
    func update_repayment_balance(){
        
        let interval = get_interval_in_days()
        let last_index = Session.shared.user.auto_pay_schedule[Session.shared.currMonth].count - 1
        
        if Session.shared.user.intervalPlan == .monthly {
            for i in Session.shared.currDay...last_index{
                Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = 0
                if i == last_index{
                    Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = Session.shared.user.auto_pay_installment
                }
            }
        } else {
            for i in stride(from: last_index, to: Session.shared.currDay, by: -1){
                Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = 0
                if (last_index - i) % interval != 0{
                    continue
                }
                Session.shared.user.auto_pay_schedule[Session.shared.currMonth][i] = Session.shared.user.auto_pay_installment
            }
        }
    }
    
    func update_installment(){
        if Session.shared.user.intervalPlan == .monthly {
            Session.shared.user.auto_pay_installment = Session.shared.user.remaining_amount
        } else {
            let interval = get_interval_in_days()
            let payment_days = get_num_payment_days(interval:interval)
            
            print(Session.shared.user.remaining_amount)
            print(payment_days)
            
            Session.shared.user.auto_pay_installment = Session.shared.user.remaining_amount / Double (payment_days)
            print(Session.shared.user.auto_pay_installment)
        }
        
    }
    
    func get_interval_in_days()->Int{
        if Session.shared.user.intervalPlan == .daily {
            return 1
        } else if Session.shared.user.intervalPlan == .weekly {
            return 7
        } else if Session.shared.user.intervalPlan == .biweekly {
            return 14
        }
        return -1
    }
    
    func get_num_payment_days(interval: Int)->Int{
        let differences = Session.shared.user.auto_pay_schedule[Session.shared.currMonth].count - Session.shared.currDay - 1
        return differences / interval + 1
    }
    
    func remaining_month(){
        Session.shared.user.remaining_amount =  Session.shared.user.repayment_schedule[Session.shared.currMonth] - Session.shared.user.repayment_balance[Session.shared.currMonth][Session.shared.currDay]
    }
    
    func intervalEnumToString(interval: User.IntervalPlan) -> String {
        switch interval {
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .biweekly:
            return "Biweekly"
        default:
            return "Monthly"
        }
    }
    
    func intervalStringToEnum(interval: String) -> User.IntervalPlan {
        switch interval {
        case "Daily":
            return .daily
        case "Weekly":
            return .weekly
        case "Biweekly":
            return .biweekly
        default:
            return .monthly
        }
    }
    
    func update_graph(chart: LineChartView, curr_plan: RepaymentPlan, alt_plans: [RepaymentPlan]){
        
        let line_width = CGFloat(3.0)
        
        let data = LineChartData()
        data.setDrawValues(false)
        
        chart.noDataText = ""

        let currLine = load_entries(plan: curr_plan,start:0, offset: 0)
        currLine.circleRadius = 0
        currLine.colors = [NSUIColor.black]
        currLine.lineWidth = line_width
        currLine.drawValuesEnabled = false
        //do curr entry styling
        data.addDataSet(currLine)
        
        let month = Session.shared.currMonthLongTerm

        let continuationPlan = Session.shared.getProjectedRepaymentPlan(plan: Session.shared.user.currPlan)
        let continuationLine = load_entries(plan: RepaymentPlan(title: "Current Plan Projected",schedule: continuationPlan),start:0,offset:month)
        continuationLine.circleRadius = 0
        continuationLine.colors = [NSUIColor.black]
        continuationLine.lineWidth = line_width
        continuationLine.drawValuesEnabled = false
        continuationLine.lineDashLengths = [5,2]
        data.addDataSet(continuationLine)
        
//        let midLine = LineChartDataSet(values: middleLine, label:"Today")
//        midLine.colors = [NSUIColor.green]
//        midLine.circleRadius = 0
//        midLine.lineWidth = 2
//        midLine.drawValuesEnabled = false
//        data.addDataSet(midline)
        
        
        
                for var plan in alt_plans{
            let last = plan.schedule.count - 1
            if last > month{
                let line = load_entries(plan: plan,start: 0, offset: month)
                line.circleRadius = 0
                line.colors = [NSUIColor.white]
                line.lineWidth = line_width
                line.drawValuesEnabled = false
                // do line styling
                data.addDataSet(line)
            }
        }
        
        chart.data = data
        
    }
    
    func load_entries(plan: RepaymentPlan, start: Int, offset: Int) -> LineChartDataSet{
        let arr = plan.schedule
        var entries = [ChartDataEntry]()
        let length = arr.count
        
        for i in start...(length-1){
            let val = ChartDataEntry(x: Double(i + offset),y: arr[i])
            entries.append(val)
        }
        let line = LineChartDataSet(values:entries, label: plan.title)
        return line
    }
    
    func doubleToDollar(num1: Double)->String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let num = numberFormatter.string(from: NSNumber(value:num1))
        return "$" + num!
    }
}
