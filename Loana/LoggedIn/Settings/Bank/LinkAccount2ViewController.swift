//
//  LinkAccount2ViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 12/6/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class LinkAccount2ViewController: UIViewController {
    
    @IBOutlet weak var accNameField: UITextField!
    @IBOutlet weak var routingNumberField: UITextField!
    var bankName: String?
    var delegate: LinkAccount3ViewControllerDelegate?
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func linkAccount(_ sender: UIButton) {
        
    }
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var logInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: bankName!)
        logInLabel.font = UIFont(name: "Avenir", size: 30)
        
        loginButton.layer.cornerRadius = 22
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.darkGray.cgColor
        // Do any additional setup after loading the view.
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "linkAcc3", let destination = segue.destination as? LinkAccount3ViewController {
            destination.label1text = "Peter Lu's Checking"
            destination.label2text = "xxxxxx0623"
            destination.bankTitle = bankName
            destination.delegate = delegate
        }
    }
}
