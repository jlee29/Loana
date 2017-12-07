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
    
    @IBAction func linkAccount(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
}
