//
//  PlansViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlanDetailViewControllerDelegate {
    
    @IBOutlet weak var currentPlanLabel: UILabel!
    
    func updatedPlan(_ plan: String) {
        currentPlanLabel.text = "Current plan is: " + plan
        plans = allPlans.filter {$0 != plan}
        plansTableView.reloadData()
    }
    
    var allPlans = ["IBR", "PAYE", "ICR", "Standard", "Graduated", "Extended", "A", "B", "C", "D", "E"]
    var plans = ["IBR", "PAYE", "ICR", "Standard", "Graduated", "Extended", "A", "B", "C", "D", "E"]
    var currPlan: String?

    @IBOutlet weak var plansTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plansTableView.delegate = self
        plansTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let title: UILabel = UILabel()
//
//        title.text = "Other Repayment Plans"
//        title.textColor = UIColor(red: 77.0/255.0, green: 98.0/255.0, blue: 130.0/255.0, alpha: 1.0)
//        title.textAlignment = NSTextAlignment.center
//
//        title.backgroundColor = UIColor(red: 225.0/255.0, green: 243.0/255.0, blue: 251.0/255.0, alpha: 1.0)
//        title.font = UIFont.boldSystemFont(ofSize: 18)
//
//        return title
//    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = plansTableView.dequeueReusableCell(withIdentifier: "plan", for: indexPath) as! PlansTableViewCell
        cell.label1.text = plans[indexPath.row]
        cell.label2.text = "10"
        cell.label3.text = "100"
        cell.label4.text = "400"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let destination = segue.destination as? PlanDetailViewController {
            if let cell = sender as? PlansTableViewCell, let indexPath = plansTableView.indexPath(for: cell) {
                let planName = plans[indexPath.row]
                destination.testString = planName
                destination.delegate = self
            }
        }
    }
}
