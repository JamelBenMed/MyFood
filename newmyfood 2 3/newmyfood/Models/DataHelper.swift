//
//  DataHelper.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit
import Alamofire

class DataHelper {
    static let sharedInstance = DataHelper()
    var user = User()

    var alamoFireManager : Alamofire.SessionManager?
    
    
    func alamofireManager()->Alamofire.SessionManager{
        if (alamoFireManager == nil){
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 60
            configuration.timeoutIntervalForResource = 60
            self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        }
        return alamoFireManager!
        
}
    func returnPassword()->String{
        
        if let password =  UserDefaults.standard.object(forKey: Constants.UserDefault.PassWord) as? String{
            
            return password
        }
        return ""
    }
}
