//
//  HomeScrollContentViewController.swift
//  Loana
//
//  Created by Jaime Deverall on 08/12/2017.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class HomeContentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let currMonth = Session.shared.currMonth
    let currDay = Session.shared.currDay
    
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
            cell.welcomeText.text = String(format: "$%.02f", Session.shared.user.auto_pay_installment)
            switch Session.shared.user.intervalPlan {
            case .daily:
                cell.intervalText.text = "For Today"
            case .weekly:
                cell.intervalText.text = "For This Week"
            case .biweekly:
                cell.intervalText.text = "For These Two Weeks"
            default:
                cell.intervalText.text = "For This Month"
            }
            let proPicImage = UIImage(named: "shoes.png")
            cell.propic.contentMode = .scaleAspectFit
            cell.propic.image = proPicImage
            return cell
        }
        if (indexPath.row == 1) {
            let cell = mainView.dequeueReusableCell(withReuseIdentifier: "coffee", for: indexPath)
            return cell
        }
        if (indexPath.row == 4) {
            let cell = mainView.dequeueReusableCell(withReuseIdentifier: "stats", for: indexPath) as! StatsCollectionViewCell
            return cell
        } else {
            let cell = mainView.dequeueReusableCell(withReuseIdentifier: "graph", for: indexPath) as! GraphCollectionViewCell
//            if indexPath.row == 2 {
//                cell.mainView =
//            } else {
//
//            }
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
