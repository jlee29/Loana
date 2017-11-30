//
//  LoginViewController.swift
//  Loana
//
//  Created by Miguel Ayala on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var passwordOne: UITextField!
    @IBOutlet weak var passwordTwo: UITextField!
    
    var validLogin: Bool = false
    
    @IBAction func signUp(_ sender: UIButton) {
        if(passwordOne.text != passwordTwo.text){
            print("passwords not the same")
            validLogin = false
        }else if( strlen(passwordOne.text) < 8){
            print("password is too short")
            validLogin = false
        }else {
            validLogin = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return validLogin
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     */
    
}

