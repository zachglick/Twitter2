//
//  TweetsViewController.swift
//  Twitter2
//
//  Created by Zach Glick on 2/23/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                print(tweet.name)
                print(tweet.screenname)
                print(tweet.text)
                print(tweet.profileUrl)
                print(tweet.age)
                print("\n")
            }
            self.tableView.reloadData()

            }) { (error:NSError) -> () in
                print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil{
            return tweets.count
        }
        else{
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        
        let tweet = tweets[indexPath.row]
        cell.nameLabel.text = tweet.name as? String
        cell.screenNameLabel.text = tweet.screenname as? String
        cell.descriptionLabel.text = tweet.text as? String
        cell.profileImageView.setImageWithURL(tweet.profileUrl!)
        cell.ageLabel.text = tweet.age
        cell.retweetLabel.text = String(tweet.retweetCount)
        cell.favoriteLabel.text = String(tweet.favoritesCount)
        //cell.profileImageView.backgroundColor = UIColor.blackColor()
        
        
        
        
        return cell
        
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        
        TwitterClient.sharedInstance.logout()
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("TRuuueeee")
        if(segue.destinationViewController is TweetViewController){
            print("tweet view controller")

            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let tweetViewController = segue.destinationViewController as! TweetViewController
            tweetViewController.tweet = tweet
            
            
        }
        else if(segue.destinationViewController is ComposeViewController){
            print("compose view controller")
            
            
        }
        else if(segue.destinationViewController is profileViewController){
            print("profile view controller")
        }
        
        
       /* let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let business = filteredBusinesses![indexPath!.row]
        let mapViewController = segue.destinationViewController as! MapViewController
        mapViewController.business = business*/
        
        
        
    }


}
