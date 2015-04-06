//
//  TabBarController.swift
//  djazz
//
//  Created by Richard Walker on 06/04/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preload the events view 
        // (takes care of setting the badge icon on the "events" tab bar item
        let eventsNavController = self.viewControllers![1] as UINavigationController
        let rootController = eventsNavController.viewControllers[0] as UIViewController
        let view = rootController.view
        

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
