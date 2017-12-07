//
//  HomeViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/30/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var slideMenuHidden = true
    
    var user = Session.shared.user

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var proPic: UIImageView!
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        welcomeLabel.text = "Welcome Back " + Session.shared.user.name + "!"
        welcomeLabel.font = UIFont(name: "Avenir", size: 25)

        proPic.layer.cornerRadius = 37
        sideMenuConstraint.constant = -140
        // Do any additional setup after loading the view.
    }
    
    func calculate_(){
        
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
