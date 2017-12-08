//
//  LinkAccountViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 12/6/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class LinkAccountViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    var delegate: LinkAccount3ViewControllerDelegate?

    @IBOutlet weak var bankCollection: UICollectionView!
    
    var names = ["barclay.png", "boa.png", "chase.png", "hsbc.png", "wellsFargo.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bankCollection.delegate = self
        bankCollection.dataSource = self
        bankCollection.backgroundColor = .clear
        bankCollection.reloadData()
        
        mainLabel.font = UIFont(name: "Avenir", size: 25)
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
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bankCollection.dequeueReusableCell(withReuseIdentifier: "bank", for: indexPath) as! BankCompanyCollectionViewCell
        cell.image.image = UIImage(named: names[indexPath.row])
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let destination = segue.destination as? LinkAccount2ViewController {
            if let cell = sender as? BankCompanyCollectionViewCell, let indexPath = bankCollection.indexPath(for: cell) {
                let bankName = names[indexPath.row]
                destination.bankName = bankName
                destination.delegate = delegate
            }
        }
    }
}
