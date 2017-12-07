//
//  ProfileViewController.swift
//  Loana
//
//  Created by Jaime Deverall on 06/12/2017.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loanIDLabel: UILabel!
    @IBOutlet weak var loanProviderLabel: UILabel!
    @IBOutlet weak var publicSectorLabel: UILabel!
    @IBOutlet weak var stateOfResidenceLabel: UILabel!
    @IBOutlet weak var grossIncomeLabel: UILabel!
    @IBOutlet weak var maritalStatusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = Session.shared.user.name
        loanIDLabel.text = Session.shared.user.loanID
        loanProviderLabel.text = Session.shared.user.loanProvider
        publicSectorLabel.text = StringToResponse(str: BoolToString(b: Session.shared.user.publicSector))
        stateOfResidenceLabel.text = Session.shared.user.stateOfResidence
        grossIncomeLabel.text = String(Session.shared.user.income)
        maritalStatusLabel.text = Session.shared.user.maritalStatus
        // Do any additional setup after loading the view.
    }
    
    func BoolToString(b: Bool?)->String { return b?.description ?? "<None>"}
    
    func StringToResponse(str: String?) -> String{
        if str == "True"{
            return "Yes"
        }
        return "No"
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
