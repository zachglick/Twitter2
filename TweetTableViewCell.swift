//
//  TweetTableViewCell.swift
//  Twitter2
//
//  Created by Zach Glick on 2/23/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var tweetId : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onRetweet(sender: AnyObject) {
        var original = Int(retweetLabel.text!)
        original = original! + 1
        retweetLabel.text = String(original!)
        TwitterClient.sharedInstance.retweet(tweetId!)
        
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        var original = Int(favoriteLabel.text!)
        original = original! + 1
        favoriteLabel.text = String(original!)
        TwitterClient.sharedInstance.favorite(tweetId!)

        
    }

}
