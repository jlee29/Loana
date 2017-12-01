//
//  NavigationBar.swift
//  Loana
//
//  Created by Jiwoo Lee on 11/30/17.
//  Copyright © 2017 Jiwoo Lee. All rights reserved.
//

import UIKit


class NavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        self.topItem?.titleView = UIImageView(image: UIImage(named: "hat30.png"))
    }
    
    override func popItem(animated: Bool) -> UINavigationItem? {
        return super.popItem(animated: false)
    }
    
    override func pushItem(_ item: UINavigationItem, animated: Bool) {
        return super.pushItem(item, animated: false)
    }
    
}
