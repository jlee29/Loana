//
//  LoginViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func logIn(_ sender: UIButton) {
        
    }
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var mainStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "hat30.png"))
        emailField.delegate = self
        passwordField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        self.view.insertSubview(backgroundImage, at: 0)
        let fontSize = loginButton.titleLabel?.font.pointSize
        let avenirFont = UIFont(name: "Avenir", size: fontSize!)
        loginButton.titleLabel?.font = avenirFont
        signUpButton.titleLabel?.font = avenirFont
        
        emailField.textContentType = UITextContentType.init(rawValue: "")
        passwordField.textContentType = UITextContentType.init(rawValue: "")
        mainView.layer.cornerRadius = 10
        errorMessageLabel.text = ""
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // needed to clear the text in the back navigation:
        self.navigationItem.title = " "
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "login"{
            if emailField.text == "jaime1deverall@gmail.com" && passwordField.text == "iloveCS147"{
                Session.shared.loggedIn = true
                return true
            }
            errorMessageLabel.text = "Email or password incorrect"
            return false
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
