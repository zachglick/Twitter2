//
//  TwitterClient.swift
//  Twitter2
//
//  Created by Zach Glick on 2/23/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance =  TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "UDulHemH8fNlJTvq1jU9xkePI", consumerSecret: "9kpSUJBfxUqG2eyTtBMWH3b5Zw6yLBlyZQ4jffOkucvPTENbdd")
    
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    func currentAccount(success: (User) -> (), failure: (NSError)-> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            // print("account : \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
                
                
        })
    }
    
    
    func retweet(id: String) {
        
        POST("https://api.twitter.com/1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in

            print("ID \(id)")
            
            
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print("Couldn't retweet")
        })
    }
    
    
    func favorite(id: String) {
        
        POST("https://api.twitter.com/1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("ID \(id)")

            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Couldn't favorite")

                
        })
    }
    
    
    func tweet(text: String) {
        
        POST("https://api.twitter.com/1.1/statuses/update.json", parameters: ["status":text], progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("ID \(text)")
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Couldn't tweet")
                
                
        })
    }
    
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("account : \(response)")
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
               
                failure(error)
                
        })
        
    }
    
    func login(success: () -> (), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitter2://GlickOauth"), scope: nil, success: { (requestToken :BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(url!)
            
            }) { (error : NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
                
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token")
            
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error:NSError) -> () in
                    self.loginFailure?(error)
            })
            self.loginSuccess?()
            
            
            }) { (error: NSError!) -> Void in
                print("error \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
}
