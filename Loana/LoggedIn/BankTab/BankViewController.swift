//
//  BankViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 12/6/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class BankViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
            return cell
        }
    }
}
