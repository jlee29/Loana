//
//  BankViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 12/6/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class BankViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, LinkAccount3ViewControllerDelegate {
    
    @IBOutlet weak var currBankLabel1: UILabel!
    @IBOutlet weak var currBankLabel2: UILabel!
    
    var bankNames = ["Wells Fargo", "Wells Fargo"]
    var linkedAccounts = ["Peter Lu's Checking", "Peter Lu's Savings"]
    var linkedAccountTexts = ["Checking xxx5067", "Savings xxx5067"]

    @IBOutlet weak var bankCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currBankLabel1.text = Session.shared.user.bankAccount.accountName
        currBankLabel2.text = Session.shared.user.bankAccount.number
        
        bankCollection.delegate = self
        bankCollection.dataSource = self
        bankCollection.backgroundColor = .clear
        bankCollection.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        
        if let indexPath = self.bankCollection.indexPathForItem(at: sender.location(in: self.bankCollection)) {
            if indexPath.row < 2 {
                let cell = self.bankCollection.cellForItem(at: indexPath) as! BankCollectionViewCell
                let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to switch accounts?", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    let newAccName = cell.label1.text!
                    let newAccNum = cell.label2.text!
                    cell.label1.text = Session.shared.user.bankAccount.accountName
                    cell.label2.text = Session.shared.user.bankAccount.number
                    self.currBankLabel1.text = newAccName
                    self.currBankLabel2.text = newAccNum
                    Session.shared.user.bankAccount.accountName = newAccName
                    Session.shared.user.bankAccount.number = newAccNum
                })
                
                // Create Cancel button with action handlder
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                    print("Cancel button tapped")
                }
                
                //Add OK and Cancel button to dialog message
                dialogMessage.addAction(ok)
                dialogMessage.addAction(cancel)
                
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
            }
        } else {
            print("collection view was tapped")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + linkedAccounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == linkedAccounts.count) {
            let cell = bankCollection.dequeueReusableCell(withReuseIdentifier: "add", for: indexPath) as! AddCollectionViewCell
            cell.label1.text = "Add New Account"
            cell.button.setImage(UIImage(named: "icons8-plus-100.png"), for: .normal)
            return cell
        } else {
            let cell = bankCollection.dequeueReusableCell(withReuseIdentifier: "bankCell", for: indexPath) as! BankCollectionViewCell
            cell.label1.text = linkedAccounts[indexPath.row]
            cell.label2.text = linkedAccountTexts[indexPath.row]
            cell.button.setImage(UIImage(named: "icons8-forward-100.png"), for: .normal)
            cell.cellView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
            return cell
        }
    }
    
    func addedBank(_ acc: BankAccount) {
        bankNames.insert(acc.bankName, at: 0)
        linkedAccounts.insert(acc.accountName, at: 0)
        linkedAccountTexts.insert(acc.number, at: 0)
        bankCollection.reloadData()
    }
    
    func kickBack() {
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.popViewController(animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "linkAcc1", let destination = segue.destination as? LinkAccountViewController {
            if let cell = sender as? AddCollectionViewCell, let _ = bankCollection.indexPath(for: cell) {
                destination.delegate = self
            }
        }
    }
    
}
