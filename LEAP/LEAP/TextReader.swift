//
//  TextReader.swift
//  LEAP
//
//  Created by Magic on 16/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class TextReader
{

    class func processParsingJSON(urlToRequest:String) -> NSDictionary{
        
        let rawJSON  = NSData(contentsOfURL:NSURL(fileURLWithPath:urlToRequest)!)
        
        var error: NSError?
        var retDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(rawJSON!, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        return retDict
    }
    
    class func parseJSON(urlToRequest:String) -> NSDictionary{
        return processParsingJSON(urlToRequest)
    }
    
    class func parseManagerData(webserviceURL:String)->NSDictionary{
        
        return processParsingJSON(webserviceURL)
    }
    
    class func parseLearnerData(webserviceURL:String)->NSDictionary{
        
        return processParsingJSON(webserviceURL)
    }
}
