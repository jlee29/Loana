//
//  ViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/17/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit
import Charts

class Graph1Controller: UIViewController {
    
    @IBOutlet var chart: LineChartView!
    
    var numbers = [13,14,15,25,28,33,44]
    
    var month = Session.shared.currMonth
    var day = Session.shared.currDay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        updateGraph()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGraph(){
        chart.noDataText = ""
        var paidEntry = [ChartDataEntry]()
        var pastNum = 0.0
        for index in 0...day {
            let val = ChartDataEntry(x: Double(index),y: Session.shared.user.repayment_balance[month][index])
            if Session.shared.user.repayment_balance[month][index] != pastNum, index > 0 {
                let prevVal = ChartDataEntry(x: Double(index-1),y: Session.shared.user.repayment_balance[month][index])
                paidEntry.append(prevVal)
                pastNum = Session.shared.user.repayment_balance[month][index]
            }
            paidEntry.append(val)
        }
        var repayment_balance_copy = Session.shared.user.repayment_balance
        var projectedEntry = [ChartDataEntry]()
        for index in (day + 1)...(Session.shared.user.repayment_balance[month].count-1){
            
            //update copy
            if index != 0{
                repayment_balance_copy[month][index] = repayment_balance_copy[month][index-1] + Session.shared.user.auto_pay_schedule[month][index]
            }
            
            let val = ChartDataEntry(x: Double(index),y: repayment_balance_copy[month][index])
            
            if repayment_balance_copy[month][index] != pastNum, index > 0 {
                let prevVal = ChartDataEntry(x: Double(index-1),y: repayment_balance_copy[month][index])
                projectedEntry.append(prevVal)
                pastNum = repayment_balance_copy[month][index]
            }
            
            projectedEntry.append(val)
        }
        
        var middleLine = [ChartDataEntry]()
        let point1 = ChartDataEntry(x: Double(day), y: 0)
        let point2 = ChartDataEntry(x: Double(day), y: repayment_balance_copy[month][Session.shared.user.repayment_balance[month].count-1])
        middleLine.append(point1)
        middleLine.append(point2)
        
        let midLine = LineChartDataSet(values: middleLine, label:"Today")
        midLine.colors = [NSUIColor.green]
        midLine.circleRadius = 0
        midLine.lineWidth = 2
        midLine.drawValuesEnabled = false
        
        let line1 = LineChartDataSet(values: paidEntry, label: "Paid")
        line1.colors = [NSUIColor.white]
        line1.circleRadius = 0
        line1.lineWidth = 5
        line1.drawValuesEnabled = false
        
        let line2 = LineChartDataSet(values: projectedEntry, label: "Projected")
        line2.colors = [NSUIColor.white]
        line2.circleRadius = 0
        line2.lineDashLengths = [5,3]
        line2.lineWidth = 5
        line2.drawValuesEnabled = false
        
        let data = LineChartData()
        data.setDrawValues(false)
    
        data.addDataSet(line1)
        data.addDataSet(line2)
        data.addDataSet(midLine)
        chart.data = data
        
        chart.chartDescription?.text = "This Month's Balance"
    }
    
}
