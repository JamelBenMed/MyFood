//
//  Utils.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit

class Utils: NSObject {
    class func makeBlankIfEmpty(_ text_ : AnyObject) -> NSString
    {
        if self.isEmptyText(text_) {
            return "";
        }
        var value: String? = text_ as? String
        
        if (value ?? "").isEmpty {
            value = "";
        }
        value = value!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil);
        return value! as NSString;
    }
    
    class func isAppInProdState()-> Bool {
        let inputFile = Bundle.main.path(forResource: "MyFood", ofType: "plist")
        
        let inputDataDict = NSDictionary(contentsOfFile: inputFile!)
        if   let result = inputDataDict?.object(forKey: "isAppInProdState") as? Bool{
            return result
        }
        return true
    }
    class func isEmptyText(_ value : AnyObject) -> Bool{
        if value is NSNull {
            return true
        } else {
            return false
        }
    }

}
