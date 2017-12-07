//
//  LinkAccount3ViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 12/6/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

protocol LinkAccount3ViewControllerDelegate {
    func addedBank(_ acc: BankAccount)
    func kickBack()
}

class LinkAccount3ViewController: UIViewController {

    var delegate: LinkAccount3ViewControllerDelegate?
    
    @IBOutlet weak var image: UIImageView!
    var bankTitle: String?
    
    var label1text: String?
    var label2text: String?
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var account: UIView!
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "Alert title", message: "Link this account?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.addedCorrectly()
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped")
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func addedCorrectly() {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Linked Account!", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.delegate?.addedBank(BankAccount(bankName: self.bankTitle!, accountName: self.label1.text!, number: self.label2.text!))
            self.delegate?.kickBack()
        })

        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func selected(_ sender: UIButton) -> () {
        let alertController = UIAlertController(title: "Alert title", message: "Link this account?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.delegate?.addedBank(BankAccount(bankName: self.bankTitle!, accountName: self.label1.text!, number: self.label2.text!))
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped")
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.text = label1text
        label2.text = label2text
        image.image = UIImage(named: bankTitle!)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (checkAction(sender:)))
        account.addGestureRecognizer(gesture)

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

}
