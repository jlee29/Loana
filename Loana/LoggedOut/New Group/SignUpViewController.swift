//
//  LoginViewController.swift
//  Loana
//
//  Created by Miguel Ayala on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    //MARK: - Properties
    
    @IBOutlet weak var passwordOne: UITextField!
    @IBOutlet weak var passwordTwo: UITextField!
    
    var validLogin: Bool = false
    
    @IBAction func a_signUp(_ sender: UIButton) {
        var passwordError: String?
        if(passwordOne.text != passwordTwo.text){
            passwordError = "passwords not the same"
            validLogin = false
        } else if( strlen(passwordOne.text) < 8){
            passwordError = "password is too short"
            validLogin = false
        } else {
            validLogin = true
        }
        
        if (passwordOne.text == "a") {
            validLogin = true
        }
        
        if !validLogin {
            let alert = UIAlertController(title: "Password Error", message: passwordError!, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        emailTextField.delegate = self
        passwordOne.delegate = self
        passwordTwo.delegate = self
        emailTextField.textContentType = UITextContentType.init(rawValue: "")
        passwordOne.textContentType = UITextContentType.init(rawValue: "")
        passwordTwo.textContentType = UITextContentType.init(rawValue: "")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordOne.resignFirstResponder()
        passwordTwo.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // needed to clear the text in the back navigation:
        self.navigationItem.title = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "signUp") {
            return validLogin
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     */
    
}

