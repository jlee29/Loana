//
//  LoginViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/29/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        emailField.delegate = self
        passwordField.delegate = self
        emailField.layer.cornerRadius = 20
        emailField.layer.borderWidth = 1
        passwordField.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 22
        passwordField.layer.borderWidth = 1
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
        if let attributedTitle = loginButton.attributedTitle(for: .normal) {
            let formattedString = NSMutableAttributedString()
            formattedString.bold(
                attributedTitle.string)
            loginButton.setAttributedTitle(formattedString, for: .normal)
        }
//        errorMessageLabel.text = ""
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
            if emailField.text == "jaime1deverall@gmail.com" && passwordField.text == "iloveCS147" || emailField.text == "a" {
                Session.shared.loggedIn = true
                return true
            }
            let alert = UIAlertController(title: "Invalid Credentials", message: "Couldn't find an account with that info.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
//            errorMessageLabel.text = "Email or password incorrect"
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
