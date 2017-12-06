//
//  LinkAccountViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 12/6/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class LinkAccountViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var bankCollection: UICollectionView!
    
    var names = ["barclay.png", "boa.png", "chase.png", "hsbc.png", "wellsFargo.png"]
    
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
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bankCollection.dequeueReusableCell(withReuseIdentifier: "bank", for: indexPath) as! BankCompanyCollectionViewCell
        cell.image.image = UIImage(named: names[indexPath.row])
        return cell
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
