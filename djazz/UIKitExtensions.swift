//
//  UIViewControllerExt.swift
//  djazz
//
//  Created by Richard Walker on 28/02/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   
    /// Displays a modal popup on the current view
    func alert(title: String, message: String, buttonText: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /// Displays a modal error popup on the current view
    func error(error:NSError, message: String) {

        var title: String
        switch error.domain {
        case "NSURLErrorDomain":
            title = "Network Error"
        default:
            title = "Error"
        }
        
        self.alert(title, message: "\n\(message)\n\n\(error.localizedDescription)", buttonText: "Ok")
    }
    
}