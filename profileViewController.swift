//
//  profileViewController.swift
//  Twitter2
//
//  Created by Zach Glick on 2/28/16.
//  Copyright © 2016 Zach Glick. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "Zach Glick"
        screenNameLabel.text = "@Glick132CSE"
        profileImageView.setImageWithURL(NSURL(string: "https://abs.twimg.com/a/1456432130/img/t1/highline/empty_state/owner_empty_avatar.png")!)
        

        
        
        // Do any additional setup after loading the view.
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

}
