//
//  TweetViewController.swift
//  Twitter2
//
//  Created by Zach Glick on 2/28/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
 
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var tweet : Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = tweet?.name as? String
        screennameLabel.text = tweet?.screenname as? String
        descriptionLabel.text = tweet?.text as? String
        favoriteLabel.text = String((tweet?.favoritesCount)!)
        retweetLabel.text = String((tweet?.retweetCount)!)
        profileImageView.setImageWithURL(tweet!.profileUrl!)
        
        dateLabel.text = tweet?.age
        

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet((tweet?.id)!)
        self.retweetLabel.text = String((tweet?.retweetCount)!+1)
        
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite((tweet?.id)!)
        self.favoriteLabel.text = String((tweet?.favoritesCount)!+1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
