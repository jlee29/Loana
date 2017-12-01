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
        currentPlanLabel.text = "Current plan is: " + currentPlan
        currentPlanLabelOnCard.text = currentPlan
        plans = allPlans.filter {$0 != currentPlan}
        plansCollectionView.reloadData()
    }
    
    var allPlans = ["IBR", "PAYE", "ICR", "Standard", "Graduated", "Extended", "A", "B", "C", "D", "E"]
    var plans = ["IBR", "PAYE", "ICR", "Standard", "Graduated", "Extended", "A", "B", "C", "D", "E"]
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
        cell.boxImg.layer.cornerRadius = 10
        cell.boxImg.clipsToBounds = true
        cell.backgroundColor = .clear
        return cell
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
