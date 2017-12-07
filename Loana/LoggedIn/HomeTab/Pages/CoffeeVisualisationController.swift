//
//  CoffeeVisualisationController.swift
//  Loana
//
//  Created by Jaime Deverall on 07/12/2017.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class CoffeeVisualisationController: UIViewController {
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intervalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        intervalLabel.numberOfLines = 0
        intervalLabel.text = getIntervalText()
        imageView.image = UIImage(named: getImageName())
        timesLabel.text = String(getTimes())
    }
    
    func getObjectName()->String{
        let plan = Session.shared.user.intervalPlan
        if plan == "Daily"{
            return "coffees"
        } else if plan == "Weekly"{
            return "shoes"
        } else if plan == "Biweekly"{
            return "concert tickets"
        }else{
            return "headphones"
        }
    }
    
    func getTimes()->Int{
        let times = Session.shared.user.auto_pay_installment / getPrice()
        return Int(round(times))
    }
    
    func getPrice()->Double{
        let plan = Session.shared.user.intervalPlan
        if plan == "Daily"{
            return 7.0
        } else if plan == "Weekly"{
            return 50.0
        } else if plan == "Biweekly"{
            return 100.0
        }else{
            return 200.0
        }
    }
    
    func getImageName()->String{
        let plan = Session.shared.user.intervalPlan
        if plan == "Daily"{
            return "coffee.png"
        } else if plan == "Weekly"{
            return "shoes.png"
        } else if plan == "Biweekly"{
            return "tickets.png"
        }else{
            return "headphones.png"
        }
    }
    
    func getIntervalText()->String{
        var base = "Your " + Session.shared.user.intervalPlan.lowercased()
        base = base + " payment of\n" + "$" + String(format: "%.2f", Session.shared.user.auto_pay_installment) + "\n"
        base = base + " is equivalent to"
        return base
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
