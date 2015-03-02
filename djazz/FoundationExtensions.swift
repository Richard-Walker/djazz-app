//
//  FoundationExtensions.swift
//  djazz
//
//  Created by Richard Walker on 28/02/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation



// MARK: - Dates ---------------------------------------------------------------------

extension NSDate {
    
    /// Transforms a string given in the format used by djazz server (POSIX) into a NSDate object
    class func parse(dateString: String) -> NSDate? {
        /// FIXME: cache formatter
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" //equivalent in Python -> "%Y-%m-%d %H:%M:%S %z"
        return formatter.dateFromString(dateString)
    }
    
    /// Returns the time part of a date in the format 'HH:MM'
    var timePart: String {
        /// FIXME: cache formatter
        let formatter = NSDateFormatter()
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .ShortStyle
        formatter.locale = NSLocale(localeIdentifier: "fr_FR")
        return formatter.stringFromDate(self)
    }

    /// Returns a string representation of the date that is understandable by djazz server
    var jsonDate: String {
        /// FIXME: cache formatter
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" //equivalent in Python -> "%Y-%m-%d %H:%M:%S %z"
        return formatter.stringFromDate(self)
    }
    
    /// Returns a NSDate object that has the specified time part and today's date part
    class func dateFromTime(timePart: String?) -> NSDate? {
        // FIXME: validate input, return nil if incorrect
        
        let components = split(timePart!) {$0 == ":"}
        let hour = components[0].toInt()!
        let minute = components[1].toInt()!
        
        var gregorian = NSCalendar(identifier:NSGregorianCalendar)
        return gregorian!.dateBySettingHour(hour, minute: minute, second: 0, ofDate: NSDate(), options: nil)
    }
    
    class func nextOccurenceOf(timePart: String) -> NSDate {
        var date = NSDate.dateFromTime(timePart)!
        if NSDate().compare(date) == NSComparisonResult.OrderedDescending {
            var gregorian = NSCalendar(identifier:NSGregorianCalendar)
            date = gregorian!.dateByAddingUnit(.CalendarUnitDay, value: 1, toDate: date, options: nil)!
        }
        return date
    }
    
}



// MARK: - Arrays & Dictionaries ---------------------------------------------------------------------

extension Array {
    
    var first: T? {
        if isEmpty {
            return nil
        }
        
        return self[0]
    }
    
    var last: T? {
        if isEmpty {
            return nil
        }
        
        return self[count - 1]
    }
    
    /// Find first element in array that matches predicate
    func find(includedElement: T -> Bool) -> T? {
        for (idx, element) in enumerate(self) {
            if includedElement(element) {
                return element
            }
        }
        return nil
    }
    
}

extension Dictionary {
    
    func map(transform: (Value) -> (Value)) -> [Key:Value] {
        var newDictionary: [Key:Value] = [:]
        for (key,value) in self {
            var newValue = transform(value)
            newDictionary[key] = newValue
        }
        return newDictionary
    }
    
    // FIXME: make it really json safe by checking that all values are literals
    var jsonSafe: [Key:Value] {
        
        return self.map {
            if $0 is NSDate {
                return ($0 as NSDate).jsonDate as Value
            } else {
                return $0
            }
        }
    }
    
}



