//
//  LinkAccount2ViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 12/6/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class LinkAccount2ViewController: UIViewController, UITextFieldDelegate {
    
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
        accNameField.delegate = self
        routingNumberField.delegate = self
        
        loginButton.layer.cornerRadius = 22
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.darkGray.cgColor
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == routingNumberField {
            moveTextField(textField, moveDistance: -250, up: true)
        }
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == routingNumberField {
            moveTextField(textField, moveDistance: -250, up: false)
        }
    }
    
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        accNameField.resignFirstResponder()
        routingNumberField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "linkAcc3", let destination = segue.destination as? LinkAccount3ViewController {
            destination.label1text = "Peter Lu's Checking"
            destination.label2text = "xxxxxx0623"
            destination.bankTitle = bankName
            destination.delegate = delegate
        }
    }
}
