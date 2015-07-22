//
//  ManagerViewController.swift
//  LEAP
//
//  Created by Magic on 14/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class ManagerViewController: BaseEmployeeViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate {

    private let reuseIdentifier = "LearnerCollectionViewCell"
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var filterLearnerButton:UIButton!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var logoutButton:UIButton!
    
    var tagArray = [20,2,5,9,7,11]
    var selectedTagIndex = 0
    var filterList:FilterListViewController?
    var popoverController:UIPopoverController?
    var filterType = "all"
    
    //JSON Model Objects
    var courseList = []
    var learnerList = []
    var myInfo = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.buildUI();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func buildUI(){
        
        //Pull all data
        // TO DO - put nil check
        self.wsResponseAsJSON = TextReader.parseManagerData(NSBundle.mainBundle().pathForResource("managerData", ofType:"txt")!)
        
        self.courseList = self.wsResponseAsJSON.valueForKeyPath("courses")! as! NSArray
        self.learnerList = self.wsResponseAsJSON.valueForKeyPath("learnerList")! as! NSArray
        self.myInfo = self.wsResponseAsJSON.valueForKeyPath("my_info") as! NSDictionary
        
        let strusername = self.myInfo.valueForKeyPath("name") as? String
        self.userName.text = "Hello! \(strusername!)"
        
        self.collectionView!.backgroundColor = UIColor.clearColor()
        
        //courseListCell
        let tableNib = UINib(nibName:"CourseListCell", bundle: nil)
        self.tableView!.registerNib(tableNib,forCellReuseIdentifier:"courseListCell")
        
        let nib = UINib(nibName:self.reuseIdentifier, bundle: nil)
        collectionView!.registerNib(nib, forCellWithReuseIdentifier:self.reuseIdentifier)
        
        self.filterList = FilterListViewController(nibName:"FilterListViewController",bundle:nil)
        
        let tempList  = self.myInfo.valueForKeyPath("tagFilterList") as! String
        
        self.filterList?.filterList = tempList.componentsSeparatedByString(",")
        
        self.popoverController = UIPopoverController(contentViewController: self.filterList!)
        self.popoverController!.popoverContentSize = CGSizeMake(268.0,300.0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"onFilterLearnerListChanged:", name:"filterLearnerList", object: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //1
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterLearners().count
    }
    
    //3
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! LearnerCollectionViewCell
        //cell.backgroundColor = UIColor.redColor()
        var imgName = self.learnerList[indexPath.row].valueForKeyPath("image") as! String
        var learnerName = self.learnerList[indexPath.row].valueForKeyPath("name") as! String
        cell.userImage!.image = UIImage(named:imgName)
        cell.userName!.text = learnerName
        cell.userName!.backgroundColor = UIColor.grayColor()
        
        // Configure the cell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell:LearnerCollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! LearnerCollectionViewCell
        
        if cell.userName!.backgroundColor == UIColor.grayColor(){
            cell.userName!.backgroundColor = UIColor.greenColor()
        }else{
            cell.userName!.backgroundColor = UIColor.grayColor()
        }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("courseListCell", forIndexPath: indexPath) as! CourseListCell
        
        // Configure the cell...
        let courseName = self.courseList[indexPath.row].valueForKeyPath("course_name") as! String
        cell.courseTitle.text = "\(courseName)"
        
        let courseDuration = self.courseList[indexPath.row].valueForKeyPath("course_duration") as! String
        cell.courseDuration.text = "\(courseDuration)"
        
        let seatsAvailable = self.courseList[indexPath.row].valueForKeyPath("seats_available") as! String
        cell.seatsAvailable.text = "\(seatsAvailable)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FilterListCell
//        let title = cell.filterName.text
//        let dict  = ["index":indexPath.row, "title":"\(title)"]
    }
    
    /***************** TableView Delegate Methods *******************/
    
    @IBAction func filterLearner(sender:UIButton){
    
        //self.collectionView!.reloadData()
        self.popoverController?.presentPopoverFromRect(sender.frame, inView:self.view, permittedArrowDirections:.Down, animated:true)
    }
    
    
    func filterLearners()->NSArray{
        
        var filteredLearnerList:NSMutableArray = [];
        
        //initial load or all
        if(self.filterType == "all"){
            
            return self.learnerList;
        }
        
        for(var i=0;i<self.learnerList.count;i++){
            
            let item:AnyObject = self.learnerList[i]
            let tags = item.valueForKeyPath("tags")! as! String
            let tagList = tags.componentsSeparatedByString(",")
            
            for(var j=0;j<tagList.count;j++){
                
                if(tagList[j] == self.filterType){
                    
                    filteredLearnerList.addObject(item)
                    break
                }
            }
        }
    
        return filteredLearnerList;
    }
    
    func onFilterLearnerListChanged(aNotification:NSNotification){

        let title = aNotification.object?.valueForKey("title") as! String
        let index  = aNotification.object?.valueForKey("index") as! Int
        
        self.filterType  = self.filterList?.filterList[index] as! String
        self.filterLearners();

        self.selectedTagIndex = index;
        self.collectionView!.reloadData()
        //self.filterLearnerButton.setTitle(title, forState: .Normal)
        self.popoverController?.dismissPopoverAnimated(true)
    }
    
    @IBAction func onLogoutButtonTap(sender:UIButton){
        
        NSNotificationCenter.defaultCenter().postNotificationName("logOutRequest", object:self)
    }
    
    override func flush(){
        
    }
}
