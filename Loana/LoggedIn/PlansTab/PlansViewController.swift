//
//  PlansViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PlanDetailViewControllerDelegate {
    
    @IBOutlet weak var currentPlanLabel: UILabel!
    
    @IBOutlet weak var currentPlanLabelOnCard: UILabel!
    
    var currentPlan: String = Session.shared.user.currPlan
    
    func updatedPlan(_ plan: String) {
        currentPlan = plan
        Session.shared.user.currPlan = plan
        reloadCollection()
    }
    
    func reloadCollection() {
        currentPlanLabelOnCard.text = currentPlan
        plans = allPlans.filter {$0 != currentPlan}
        plansCollectionView.reloadData()
    }
    
    var allPlans = ["IBR", "PAYE", "ICR", "Standard", "Graduated", "Extended"]
    var plans = ["IBR", "PAYE", "ICR", "Standard", "Graduated", "Extended"]
    var currPlan: String?
    
    @IBOutlet weak var plansCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        plansCollectionView.delegate = self
        plansCollectionView.dataSource = self
        plansCollectionView.backgroundColor = .clear
        reloadCollection()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = plansCollectionView.dequeueReusableCell(withReuseIdentifier: "plan", for: indexPath) as! PlansCollectionViewCell
        cell.testLabel.text = plans[indexPath.row]
        cell.label2.text = getMonthlyPayment(plans[indexPath.row])
        cell.label2.font = UIFont(name: "Avenir", size: 12)
        cell.label3.text = getTotalMonths(plans[indexPath.row])
        cell.label3.font = UIFont(name: "Avenir", size: 12)
        
        cell.boxImg.layer.cornerRadius = 10
        cell.boxImg.clipsToBounds = true
        cell.backgroundColor = .clear
        return cell
    }
    
    func getMonthlyPayment(_ plan: String) -> String {
        if(plan == "IBR"){
            return "$150/mo"
        }else if(plan == "ICR"){
            return "$160/mo"
        }else if(plan == "PAYE"){
            return "$170/mo"
        }else if(plan == "Standard"){
            return "$200/mo"
        }else if(plan == "Graduated"){
            return "$220/mo"
        }else{
            return "$230/mo"
        }
    }
    
    func getTotalMonths(_ plan: String) -> String {
        if(plan == "IBR"){
            return "300 months"
        }else if(plan == "ICR"){
            return "240 months"
        }else if(plan == "PAYE"){
            return "300 months"
        }else if(plan == "Extended"){
            return "240 months"
        }else{
            return "120 months"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let destination = segue.destination as? PlanDetailViewController {
            if let cell = sender as? PlansCollectionViewCell, let indexPath = plansCollectionView.indexPath(for: cell) {
                let planName = plans[indexPath.row]
                destination.testString = planName
                destination.delegate = self
            }
        }
    }
}
