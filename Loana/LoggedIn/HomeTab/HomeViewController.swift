//
//  HomeViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/30/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var util = Util()
    var slideMenuHidden = true
    
    let currMonth = Session.shared.currMonth
    let currDay = Session.shared.currDay

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var intervalText: UILabel!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var darkenView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var autoPayView: UIView!
    @IBOutlet weak var plansView: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        darkenView.alpha = 0
        welcomeLabel.baselineAdjustment = .alignCenters
        welcomeLabel.font = UIFont(name: "Avenir", size: 60)
        intervalText.font = UIFont(name: "Avenir", size: 15)

        sideMenuConstraint.constant = -140
        let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showProfile(_:)))
        profileView.addGestureRecognizer(profileTapGesture)
        let bankTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showBank(_:)))
        bankView.addGestureRecognizer(bankTapGesture)
        let autoPayTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showAutoPay(_:)))
        autoPayView.addGestureRecognizer(autoPayTapGesture)
        let plansTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showPlans(_:)))
        plansView.addGestureRecognizer(plansTapGesture)
    }
    
    @objc func showProfile(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profile", sender: self)
    }
    
    @objc func showBank(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "bank", sender: self)
    }
    
    @objc func showAutoPay(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "autoPay", sender: self)
    }
    
    @objc func showPlans(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "plans", sender: self)
    }
    
    @objc func dismissMenu (_ sender: UITapGestureRecognizer) {
        if !slideMenuHidden {
            sideMenuConstraint.constant = -140
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.darkenView.alpha = 0
            })
            slideMenuHidden = !slideMenuHidden
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeLabel.text = String(format: "$%.02f", Session.shared.user.auto_pay_installment)
        switch Session.shared.user.intervalPlan {
        case .daily:
            intervalText.text = "For Today"
        case .weekly:
            intervalText.text = "For This Week"
        case .biweekly:
            intervalText.text = "For These Two Weeks"
        default:
            intervalText.text = "For This Month"
        }
        util.remaining_month()
        
        if (!slideMenuHidden) {
            sideMenuConstraint.constant = -140
            slideMenuHidden = true
            darkenView.alpha = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        if slideMenuHidden {
            sideMenuConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.darkenView.alpha = 1
            })
        } else {
            sideMenuConstraint.constant = -140
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.darkenView.alpha = 0
            })
        }
        slideMenuHidden = !slideMenuHidden
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
