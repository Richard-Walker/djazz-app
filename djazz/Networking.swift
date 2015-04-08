//
//  Networking.swift
//  djazz
//
//  Created by Richard Walker on 08/04/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation
import Alamofire



/// Protocol for models
protocol NetworkDelegates {
    func networkErrorOccurred(message:String, error: NSError?)
}


/// Alamofire wrappers
class Networking {

    
    private struct Config {
        static let attempts = 10
        static let usecondsBeforeRetry : useconds_t = 500 * 1000
    }
    
    private class func requestAttempt(method: Alamofire.Method, url: String,
        parameters: [String: AnyObject]?, encoding: ParameterEncoding,
        callback: (AnyObject?, NSError?) -> Void,
        attempt: Int) {
            
            
            Alamofire.request(method, url, parameters: parameters, encoding: encoding).validate().responseJSON() {
                (_, _, data, error) in
                
                if attempt <= self.Config.attempts && (error?.code == -1009 || error?.code == -1004) {
                    
                        usleep(self.Config.usecondsBeforeRetry)
                        self.requestAttempt(method, url: url, parameters: parameters, encoding: encoding, callback: callback, attempt: attempt + 1)
                    
                } else {
                    
                    callback(data, error)
                
                }
            }
    }

    class func request(method: Alamofire.Method, url: String,
        parameters: [String: AnyObject]?,
        callback: (AnyObject?, NSError?) -> Void) {

            let encoding : ParameterEncoding = method == .GET ? .URL : .JSON
            requestAttempt(method, url: url, parameters: parameters, encoding: encoding, callback: callback, attempt: 1)
            
    }
    
}


