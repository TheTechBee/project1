//
//  LPVideoPlayer.swift
//  LEAP
//
//  Created by Magic on 20/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class LPVideoPlayer: LPBasePlayerController {

    @IBOutlet weak var titleLableItem:UILabel!
    
    var content = [:]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, content: AnyObject) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil, content: content)
        self.content = content as! NSDictionary
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleLableItem.text = self.content.valueForKeyPath("item_cat") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
