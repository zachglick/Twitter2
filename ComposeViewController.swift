//
//  ComposeViewController.swift
//  Twitter2
//
//  Created by Zach Glick on 2/28/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var homeScreen : TweetsViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweetButton(sender: AnyObject) {
        
        print("TEXT \(textField.text)")
        TwitterClient.sharedInstance.tweet(textField.text!)

        homeScreen!.loadTweets()
        
self.dismissViewControllerAnimated(false, completion: nil)    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
