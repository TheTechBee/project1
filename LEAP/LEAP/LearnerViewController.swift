//
//  LearnerViewController.swift
//  LEAP
//
//  Created by Magic on 17/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class LearnerViewController: BaseEmployeeViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var leanerName:UILabel!
    @IBOutlet weak var logoutButton:UIButton!
    
    var courseList = [];
    var myInfo = [:]
    var leapPlayer:LeapPlayerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func buildUI() {
        
        self.wsResponseAsJSON = TextReader.parseLearnerData(NSBundle.mainBundle().pathForResource("learnerData", ofType:"txt")!)
        
        self.courseList = self.wsResponseAsJSON.valueForKeyPath("my_courses") as! NSArray
        
        self.myInfo = self.wsResponseAsJSON.valueForKeyPath("my_info") as! NSDictionary
        
        let strLearnerName = self.myInfo.valueForKeyPath("name") as? String
        self.leanerName.text = "Hello! \(strLearnerName!)"
        
        let tableNib = UINib(nibName:"LearnerCourseListCell", bundle: nil)
        self.tableView!.registerNib(tableNib,forCellReuseIdentifier:"learnerCell")
    }
    
    /**************** TableView Delegate Methods **************/
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.courseList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("learnerCell", forIndexPath: indexPath) as! LearnerCourseListCell
        
        // Configure the cell...
        cell.courseTitle.text = self.courseList[indexPath.row].valueForKeyPath("course_title") as? String
        cell.courseDuration.text = self.courseList[indexPath.row].valueForKeyPath("course_duration") as? String
        cell.coursePlayButton.tag = indexPath.row
        cell.coursePlayButton.addTarget(self, action:"onCoursePlayButtonTap:", forControlEvents:UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    
    /***************** TableView Delegate Methods Ends *******************/
    
    @IBAction func onLogoutButtonTap(sender:UIButton){
        
        NSNotificationCenter.defaultCenter().postNotificationName("logOutRequest", object:self)
    }
    
    func onCoursePlayButtonTap(sender:UIButton){
     
        let selectedCourse = self.courseList[sender.tag] as! NSDictionary
        
        if nil == self.leapPlayer{
            
            self.leapPlayer = LeapPlayerController(nibName:"LeapPlayerController", bundle:nil, content:selectedCourse)
            self.view.addSubview(self.leapPlayer!.view)

        }else{
            self.leapPlayer!.view.hidden = false;
            self.leapPlayer!.content = selectedCourse
        }
    }
}
