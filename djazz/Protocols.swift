//
//  Protocols.swift
//  djazz
//
//  Created by Richard Walker on 02/04/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation

protocol NetworkDelegates {
    func networkErrorOccurred(message:String, error: NSError)
}

