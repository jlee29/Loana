//
//  BankViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 12/6/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class BankViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, LinkAccount3ViewControllerDelegate {
    
    var bankNames = ["Wells Fargo", "Wells Fargo"]
    var linkedAccounts = ["Isabella's Checking", "Isabella's Savings"]
    var linkedAccountTexts = ["Checking xxx5067", "Savings xxx5067"]

    @IBOutlet weak var bankCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bankCollection.delegate = self
        bankCollection.dataSource = self
        bankCollection.backgroundColor = .clear
        bankCollection.reloadData()
        // Do any additional setup after loading the view.
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
//            cell.cellView.addGestureRecognizer(gesture)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row != bankNames.count) {
            let bankCell = bankCollection.cellForItem(at: indexPath) as! BankCollectionViewCell
            let alertController = UIAlertController(title: "Selecting Account", message: "Use this account?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                let index = self.linkedAccounts.index(of: bankCell.label1.text!)!
                Session.shared.user.bankAccount = BankAccount(bankName: self.bankNames[index], accountName: self.linkedAccounts[index], number: self.linkedAccountTexts[index])
            }
            alertController.addAction(OKAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel button tapped")
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion:nil)
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
