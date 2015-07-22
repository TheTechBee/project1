//
//  ViewController.swift
//  LEAP
//
//  Created by Magic on 14/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    
    //UI Elements
    @IBOutlet weak var userName:UITextField!
    @IBOutlet weak var password:UITextField!
    @IBOutlet weak var logInButton:UIButton!
    
    
    //view controllers
    var manager:ManagerViewController?
    var learner:LearnerViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"onLogoutRequest:", name:"logOutRequest", object:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButtonTap(sender:UIButton){
        
        if self.userName.text == "manager" && self.password.text == "magic" {
            
            //load manager
            if(nil == self.manager){
                self.manager = ManagerViewController(nibName:"ManagerViewController", bundle:nil)
                self.view.addSubview(self.manager!.view);
            }else{
                self.manager!.view.hidden = false;
                self.manager!.buildUI();
            }
        }
        else if self.userName.text == "learner" && self.password.text == "magic"{
         
            //load learner
            if(nil == self.learner){
                
                self.learner = LearnerViewController(nibName:"LearnerViewController", bundle:nil)
                self.view.addSubview(self.learner!.view)
            }else{
                
                self.learner!.view.hidden = false;
                self.learner!.buildUI();
            }
        }
        
        self.userName.text = ""
        self.password.text = ""
    }
    
    
    /**************** NOTIFICATION METHODS **********************/
    func onLogoutRequest(aNotificaiton:NSNotification){
        
        let vc = aNotificaiton.object as! BaseEmployeeViewController
        vc.view.hidden = true;
        vc.flush()
    }
}

