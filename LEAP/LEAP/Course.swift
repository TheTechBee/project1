//
//  Course.swift
//  LEAP
//
//  Created by Magic on 17/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class Course{
    
    private var jsonDict:NSDictionary = [:]
    
    required init(jsonDict:NSDictionary){
        
        self.jsonDict = jsonDict
    }
    
    func courseTitle()->NSString{
        
        return self.jsonDict.valueForKeyPath("course_title") as! String
    }
    
    func myStatus()->NSString{
        
        return self.jsonDict.valueForKeyPath("my_status") as! String
    }
}
