//
//  CoffeeVisualisationController.swift
//  Loana
//
//  Created by Jaime Deverall on 07/12/2017.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class CoffeeVisualisationController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intervalLabel: UILabel!
    
    var util = Util()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        intervalLabel.numberOfLines = 0
        intervalLabel.text = getIntervalText() + "\(getTimes())"
//        let range = (intervalLabel.text! as NSString).range(of: " \(getTimes())..")
//        let attributedString = NSMutableAttributedString(string: intervalLabel.text!)
//        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSNumber(value: 1), range: range)
//        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0,intervalLabel.text!.count-1))
//        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.clear, range: NSMakeRange(intervalLabel.text!.count-1,1))
//        intervalLabel.attributedText = attributedString
        imageView.image = UIImage(named: getImageName())
    }
    
    func getObjectName()->String{
        let plan = Session.shared.user.intervalPlan
        switch plan {
        case .daily:
            return "coffees"
        case .weekly:
            return "shoes"
        case .biweekly:
            return "concert tickets"
        default:
            return "headphones"
        }
    }
    
    func getTimes()->Int{
        let times = Session.shared.user.auto_pay_installment / getPrice()
        return Int(round(times))
    }
    
    func getPrice()->Double{
        let plan = Session.shared.user.intervalPlan
        switch plan {
        case .daily:
            return 7.0
        case .weekly:
            return 50.0
        case .biweekly:
            return 100.0
        default:
            return 200.0
        }
    }
    
    func getImageName()->String{
        let plan = Session.shared.user.intervalPlan
        switch plan {
        case .daily:
            return "coffee.png"
        case .weekly:
            return "shoes.png"
        case .biweekly:
            return "tickets.png"
        default:
            return "headphones.png"
        }
    }
    
    func getIntervalText()->String{
        var base = "Your \(util.intervalEnumToString(interval: Session.shared.user.intervalPlan).lowercased())"
        base = base + " payment of\n" + "$" + String(format: "%.2f", Session.shared.user.auto_pay_installment) + "\n"
        base = base + " is equivalent to "
        return base
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
