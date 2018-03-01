//
//  StringExtension.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import Foundation
extension String{
    
    public func checkIfEMailWithCorrectFormat()->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
}















}
