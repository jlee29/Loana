//
//  HomeScrollContentViewController.swift
//  Loana
//
//  Created by Jaime Deverall on 08/12/2017.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit
import Charts
import Foundation

class HomeContentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var totalMonthsLabel: UILabel!
    @IBOutlet weak var totalMonthsFixedLabel: UILabel!
    @IBOutlet weak var remainingLoanCostLabel: UILabel!
    @IBOutlet weak var remainingLoanCostFixedLabel: UILabel!
    let currMonth = Session.shared.currMonth
    let currDay = Session.shared.currDay
    
    let util = Util()
    
    @IBOutlet weak var mainView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        welcomeLabel.baselineAdjustment = .alignCenters
//        welcomeLabel.font = UIFont(name: "Avenir", size: 60)
//        intervalLabel.font = UIFont(name: "Avenir", size: 15)
        mainView.delegate = self
        mainView.dataSource = self
        mainView.backgroundColor = .clear
        mainView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        welcomeLabel.text = String(format: "$%.02f", Session.shared.user.auto_pay_installment)
//        switch Session.shared.user.intervalPlan {
//        case .daily:
//            intervalLabel.text = "For Today"
//        case .weekly:
//            intervalLabel.text = "For This Week"
//        case .biweekly:
//            intervalLabel.text = "For These Two Weeks"
//        default:
//            intervalLabel.text = "For This Month"
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0) {
            let cell = mainView.dequeueReusableCell(withReuseIdentifier: "welcome", for: indexPath) as! WelcomeCollectionViewCell
            cell.welcomeText.text = "Welcome back \(Session.shared.user.name)!"
            cell.welcomeText.font = UIFont(name: "Avenir", size: 30)
            cell.welcomeText.adjustsFontSizeToFitWidth = true
            cell.welcomeText.textAlignment = .center
            cell.moneyText.text = String(format: "$%.02f", Session.shared.user.auto_pay_installment)
            cell.moneyText.font = UIFont(name: "Avenir", size: 60)
            cell.moneyText.textAlignment = .center
            cell.intervalText.textColor = UIColor.gray
            cell.intervalText.font = UIFont(name: "Avenir", size: 12)
            cell.intervalText.textAlignment = .center
            switch Session.shared.user.intervalPlan {
            case .daily:
                cell.intervalText.text = "Today"
            case .weekly:
                cell.intervalText.text = "This Week"
            case .biweekly:
                cell.intervalText.text = "These Two Weeks"
            default:
                cell.intervalText.text = "This Month"
            }
            let proPicImage = UIImage(named: "peterprofile.png")
            cell.propic.contentMode = .scaleAspectFit
            cell.propic.image = proPicImage
            return cell
        }
        if (indexPath.row == 2) {
            let cell = mainView.dequeueReusableCell(withReuseIdentifier: "coffee", for: indexPath) as! ShoesCollectionViewCell
            var imageFileName = ""
            var singleObject = ""
            var multiObject = ""
            var price = 0.0
            var interval = ""
            if Session.shared.user.intervalPlan == .daily{
                imageFileName = "coffee.png"
                singleObject = "coffee"
                multiObject = "coffees"
                price = 7.0
                interval = "daily"
            }else if Session.shared.user.intervalPlan == .weekly{
                imageFileName = "shoes.png"
                singleObject = "pair of shoes"
                multiObject = "pairs of shoes"
                price = 50.0
                interval = "weekly"
            }else if Session.shared.user.intervalPlan == .biweekly{
                imageFileName = "tickets.png"
                singleObject = "concert ticket"
                multiObject = "concert tickets"
                price = 100.0
                interval = "biweekly"
            }else{
                imageFileName = "headphones.png"
                singleObject = "pair of headphones"
                multiObject = "pairs of headphones"
                price = 200.0
                interval = "monthly"
            }
            let times = Int(round(Session.shared.user.auto_pay_installment / price))
            var object = singleObject
            if times > 1{
                object = multiObject
            }
            var text = "Your " + interval
            text = text + " payment is equivalent to \n"
            text = text + String(times) + object
            cell.timesLabel.numberOfLines = 0
            cell.timesLabel.text = text
            cell.imageView.image = UIImage(named: imageFileName)
            return cell
        }
        if (indexPath.row == 4) {
            let cell = mainView.dequeueReusableCell(withReuseIdentifier: "stats", for: indexPath) as! StatsCollectionViewCell
            cell.outerView.layer.cornerRadius = 10
            cell.adjustedIncomeFixedLabel.text = "Adjusted Income:"
            cell.adjustedIncomeLabel.text = String(Session.shared.user.age)
            cell.interestRateFixedLabel.text = "Interest Rate:"
            cell.interestRateLabel.text = "6.8%"
            cell.remainingLoanCostFixedLabel.text = "Remaining Loan Cost:"
            cell.remainingLoanCostLabel.text = util.doubleToDollar(num1:(Session.shared.getTotalLoanCost(plan: Session.shared.user.currPlan) - Session.shared.user.repaymentHistory[Session.shared.user.repaymentHistory.count - 1]))
            cell.totalMonthsFixedLabel.text = "Months Left:"
            cell.totalMonthsLabel.text = String(Session.shared.getMonthsLeft(plan: Session.shared.user.currPlan))
            return cell
        } else {
            let cell = mainView.dequeueReusableCell(withReuseIdentifier: "graph", for: indexPath) as! GraphCollectionViewCell
            if indexPath.row == 1 {
                let homeChart2 = cell.mainView
                
                util.updateGraph2(chart: homeChart2 as! LineChartView)
            } else {

                let homeChart1 = cell.mainView
                
                let plans = ["Standard","Pay As You Earn","Graduated"]
                
                let pastSchedule = Session.shared.user.repaymentHistory
                let past = RepaymentPlan(title: "Repayment History",schedule: pastSchedule)
                
                var planArr = [RepaymentPlan]()
                
                for planTitle in plans{
                    let longTermSchedule = Session.shared.getProjectedRepaymentPlan(plan: planTitle)
                    planArr.append(RepaymentPlan(title: planTitle, schedule:longTermSchedule))
                }
                
                util.update_graph(chart: homeChart1 as! LineChartView, curr_plan: past, alt_plans: planArr)
            }
            return cell
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
