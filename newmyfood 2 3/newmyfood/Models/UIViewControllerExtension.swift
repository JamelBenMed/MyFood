//
//  UIViewControllerExtension.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit
extension UIViewController{
    
    
    
public   func showAlertWith(msg:String){
        
        let alertController = UIAlertController(title: Constants.Messages.POP_UP_TITLE, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.Messages.POP_UP_OK_BTN, style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    public   func showAlertGeneralError(){
        self.showAlertWith(msg: Constants.Messages.GENERAL_ERROR)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
