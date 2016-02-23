//
//  Tweet.swift
//  Twitter2
//
//  Created by Zach Glick on 2/23/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var age: String?
    
    
    
    
    init(dictionary: NSDictionary){
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
      
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Minute], fromDate: timestamp!, toDate: NSDate(), options: [])
            let difference = components.minute
            age = String("\(difference) min")
        }
        
       
        
        
        
        let user = dictionary["user"] as? NSDictionary
        
        name = user!["name"] as? String
        screenname = user!["screen_name"] as? String
        let profileURLString = user!["profile_image_url_https"] as? String
        if let profileURLString = profileURLString{
            profileUrl = NSURL(string: profileURLString)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        return tweets
    }
}
