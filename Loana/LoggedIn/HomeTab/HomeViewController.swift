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
    
    @IBOutlet weak var proPic: UIImageView!
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))

        proPic.layer.cornerRadius = 37
        sideMenuConstraint.constant = -140
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeLabel.text = String(Session.shared.user.auto_pay_installment) + " - " + Session.shared.user.intervalPlan
        welcomeLabel.font = UIFont(name: "Avenir", size: 25)
        util.remaining_month()
        
        if (!slideMenuHidden) {
            sideMenuConstraint.constant = -140
            slideMenuHidden = true
        }
    }
    

    
//    func remaining_month(){
//        print(Session.shared.user.repayment_schedule[currMonth])
//        print(Session.shared.user.repayment_balance[currMonth][currDay])
//        Session.shared.user.remaining_amount =  Session.shared.user.repayment_schedule[currMonth] - Session.shared.user.repayment_balance[currMonth][currDay]
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        if slideMenuHidden {
            sideMenuConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            sideMenuConstraint.constant = -140
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
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
