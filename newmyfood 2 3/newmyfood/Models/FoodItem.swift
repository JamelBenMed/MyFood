//
//  FoodItem.swift
//  newmyfood
//
//  Created by jamel on 09/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//


import Foundation
class FoodItem {
    var NameProduit:String?
    var CategorieProduit:String?
    var idCatProd:  NSInteger?
   // var expanded: Bool!

    init(NameProduit:String,CategorieProduit:String, idCatProd:NSInteger){
        self.NameProduit=NameProduit
        self.CategorieProduit=CategorieProduit
        self.idCatProd=idCatProd
    //    self.expanded=expanded
        
    }
    
}

class CategorieItem {
    var NameCategorie:String?
    var idCat : NSInteger?
    
    init(NameCategorie:String, idCat:NSInteger){
        self.NameCategorie=NameCategorie
        self.idCat=idCat
    }
}
