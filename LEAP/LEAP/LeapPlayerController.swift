//
//  LeapPlayerViewController.swift
//  LEAP
//
//  Created by Magic on 17/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class LeapPlayerController: UIViewController,UIScrollViewDelegate {

    //
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var pageControl:UIPageControl!
    
    var content = [:]
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?,content:NSDictionary) {
        
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
        self.content = content
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var courseDetails = self.content.valueForKeyPath("course_details") as! NSDictionary
        var courseItems = courseDetails.valueForKeyPath("course_items") as! NSArray
        var size = CGSize(width: courseItems.count * 1024, height: 724)
        self.scrollView.contentSize = size
        
        for(var i:Int=0;i<courseItems.count;i++){
            
            println(" items \(courseItems[i]) ")
            var vp = LPVideoPlayer(nibName:"LPVideoPlayer", bundle:nil, content:courseItems[i])
            self.scrollView.addSubview(vp.view)
            
            var xp = i * 1024
            var frame = CGRect(x:xp, y: 0, width: 0, height: 0)
            vp.view.frame = frame
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /********************* UIScrollViewDelegate starts ***********************/
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    
    
    /********************* UIScrollViewDelegate ends ***********************/
}
