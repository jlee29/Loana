//
//  NavigationViewController.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/30/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    @IBOutlet weak var navBar: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "hat30.png")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
    
        self.navigationBar.topItem?.titleView = imageView

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
