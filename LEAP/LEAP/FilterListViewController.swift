//
//  FilterListViewController.swift
//  LEAP
//
//  Created by Magic on 15/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class FilterListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView:UITableView!
    
    var filterList:NSArray  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        let nib = UINib(nibName:"FilterListCell", bundle: nil)
        self.tableView!.registerNib(nib, forCellReuseIdentifier:"filterCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.filterList.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath) as! FilterListCell
        
        // Configure the cell...
        cell.filterName.text = self.filterList[indexPath.row] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FilterListCell
        let title = cell.filterName.text
        let dict  = ["index":indexPath.row, "title":"\(title)"]
        
        NSNotificationCenter.defaultCenter().postNotificationName("filterLearnerList", object:dict)
        
    }
    
}
