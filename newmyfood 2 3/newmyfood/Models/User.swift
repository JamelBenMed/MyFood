//
//  user.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var idUser:String = ""
    var name:String = ""
    var prenom:String = ""
    var userName:String = ""
    var passWord:String = ""
    var role : String = ""
    var tel:String = ""
    var mail:String = ""
    var activate:String = ""
    var espace_id:String = ""
    var adresse:String = ""
    var token:String = ""
    var image:String = ""
    var isConnect:Bool = false
    override init() {
        
    }
    init(dic:NSDictionary) {
        isConnect = true
        if let id = dic.object(forKey: "id") as? Int64{
            idUser = id.description
        }

}
    /* "id": 0,
     "username": "admin1",
     "nom": "ok",
     "prenom": "ok",
     "tel": "25588888",
     "adresse": "",
     "mail": "abdelkebir.ss@gmail.com",
     "image": null,
     "role": "admin",
     "activate": 1,
     "espace_id": null */
}
