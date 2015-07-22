//
//  LPBasePlayerComponent.swift
//  LEAP
//
//  Created by Magic on 20/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class LPBasePlayerController: UIViewController {
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?,content:AnyObject) {
        
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
