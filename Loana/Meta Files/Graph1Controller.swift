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
        for index in 0...day {
            let val = ChartDataEntry(x: Double(index),y: Session.shared.user.repayment_balance[month][index])
            
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
            
            projectedEntry.append(val)
            
        }
        
        let line1 = LineChartDataSet(values: paidEntry,label: "Paid")
        line1.colors = [NSUIColor.white]
        line1.circleRadius = 0
        line1.lineWidth = 5
        
        let line2 = LineChartDataSet(values: projectedEntry,label: "Projected")
        line2.drawValuesEnabled=false
        line1.drawValuesEnabled=false
        
        let data = LineChartData()
        data.setDrawValues(false)
        line2.colors = [NSUIColor.white]
        line2.circleRadius = 0
        line2.lineDashLengths = [5,3]
        line2.lineWidth = 5
    
        data.addDataSet(line1)
        data.addDataSet(line2)
        
        chart.data = data
        
        chart.chartDescription?.text = "This Month's Balance"
    }
    
}
