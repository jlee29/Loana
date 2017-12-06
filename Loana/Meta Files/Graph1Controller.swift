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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        // Do any additional setup after loading the view, typically from a nib.
        updateGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGraph(){
        var chartEntry = [ChartDataEntry]()
        for i in 0..<numbers.count {
            let val = ChartDataEntry(x: Double(i),y: Double(numbers[i]))
            chartEntry.append(val)
        }
        
        let line = LineChartDataSet(values: chartEntry,label: "Repayment")
        line.colors = [NSUIColor.black]
        
        let data = LineChartData()
        
        data.addDataSet(line)
        
        chart.data = data
        
        chart.chartDescription?.text = "FUC 147"
    }
    
}
