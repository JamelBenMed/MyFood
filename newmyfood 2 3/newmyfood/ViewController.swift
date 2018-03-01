//
//  ViewController.swift
//  newmyfood
//
//  Created by jamel on 09/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReadFromURL(url: URL_GET_PRODUIT)
        ReadFromURL1(url2: URL_GET_CATEGORIES)
        
    }
   
    @IBAction func BuFiltre(_ sender: Any) {
        OutCateg.forEach {
            (buttton) in
            UIView.animate(withDuration: 0.25, animations: {
                buttton.isHidden =  !buttton.isHidden
                self.view.layoutIfNeeded()
            })}}
    
    
    @IBAction func buCateg(_ sender: UIButton) {
        /* self.CollectionViewList.isHidden = !self.CollectionViewList.isHidden
        performSegue(withIdentifier: "ShowDetails", sender:FoodItem(NameProduit: ("AllProduits"), CategorieProduit: ("AllProduits")))
        var listCategories = [String]()

        guard let url = URL(string: "http://localhost:8888/myfood/Mobile/getCategories") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if response != nil {
            }
            
            if let data = data {
              //  print(data)
                do {
                var categorieJSON: NSDictionary!
                    categorieJSON =  try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                    let listCategJSON:NSArray! = categorieJSON["result"] as! NSArray
                    for elem in listCategJSON{
                    let categorie: NSDictionary = elem as! NSDictionary
                        print(categorie)
                        listCategories.append((categorie["nom"] as? String)!)
                        self.CatList.append(CategorieItem( NameCategorie: (categorie["nom"] as? String)!, idCat: (categorie["id"] as? NSInteger)!))
                        print(categorie["id"] ?? -1 )
                    }} catch {
                    print(error)
                }
                
            }
            }.resume()
            }      let produit2: NSDictionary = (idCatProd as? NSDictionary)!
            let categ_prod:NSDictionary = produit2["category"] as! NSDictionary
            self.FoodList.append(FoodItem(NameProduit: (produit2 ["nom"] as? String)!, CategorieProduit: (categ_prod["nom"] as? String)!, idCatProd: (categ_prod["id"] as? Int)!))*/
            }
    
    
    @IBOutlet weak var OutFiltre: UIBarButtonItem!
    @IBOutlet var OutCateg: [UIButton]!
    @IBOutlet weak var CollectionViewList: UITableView!
    var FoodList = [FoodItem]()
    //var filterValue:String = "AllProduits"
  //  var filterTableProduits = [FoodItem]()
    var CatList = [CategorieItem] ()
    var t_count:Int = 0
    var button_tag:Int = -1
    var lastCell: ProduitTableViewCell = ProduitTableViewCell()
    let URL_GET_PRODUIT =  "http://localhost:8888/myfood/Mobile/getProduits"
    let URL_GET_CATEGORIES = "http://localhost:8888/myfood/Mobile/getCategories"
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == button_tag {
            return 100
        } else {
            return 150
        }}
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return FoodList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProduitTableViewCell = tableView .dequeueReusableCell(withIdentifier:"mycell",  for: indexPath) as!  ProduitTableViewCell
            cell.laPrdouit.text =  FoodList [indexPath.row].NameProduit
            cell.laCategorie.text = FoodList[indexPath.row].CategorieProduit
        return cell}


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetails", sender: FoodList[indexPath.row])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accept = UIContextualAction(style: .normal, title: "Accept") { (action, view, nil) in
      
            print("Accept")
        }
        let wait = UIContextualAction(style: .normal, title: "Wait") { (action, view, nil) in}

        accept.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        accept.image = #imageLiteral(resourceName: "thumb-up-icon (3)")
        wait.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        wait.image = #imageLiteral(resourceName: "RSS-icon")
        let config = UISwipeActionsConfiguration(actions: [accept, wait])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            print("delete")
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "ShowDetails" {
            if let destination = segue.destination as? ViewController2  {
                if let produitItem = sender as? FoodItem {
                    destination.SingelItem = produitItem
                }}}}

    func ReadFromURL1 (url2: String){
        var listCategories = [String]()
        listCategories.append("AllProduits")
        let requestURL1 = NSURL(string: URL_GET_CATEGORIES)
        let request1 = NSMutableURLRequest(url: requestURL1! as URL)
        request1.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request1 as URLRequest){
            data, response, error in
            do {
                //converting resonse to NSDictionary
                var categorieJSON: NSDictionary!
                categorieJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                let listCategJSON:NSArray! = categorieJSON["result"] as! NSArray
                for elem in listCategJSON{
                    let categorie: NSDictionary = elem as! NSDictionary
                    print(categorie)
                    listCategories += [(categorie["nom"] as? String)!] // += for add more items
                    self.CatList.append(CategorieItem( NameCategorie: (categorie["nom"] as? String)!, idCat: (categorie["id"] as? NSInteger)!))
                }} catch {
                print(error)
            }}
        task.resume()
    }
    
    func ReadFromURL(url:String)   {
        let requestURL = NSURL(string: URL_GET_PRODUIT)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            //parsing the response
            do {
                //converting resonse to NSDictionary
                var produitJSON: NSDictionary!
                produitJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                //print(produitJSON)
                let listProduitJSON:NSArray! = produitJSON["result"] as! NSArray
                //print(listProduitJSON)
                for elem in listProduitJSON{
                    let produit: NSDictionary = elem as! NSDictionary
                    //print(produit)
                    let categ_prod:NSDictionary = produit["category"] as! NSDictionary
                    self.FoodList.append(FoodItem(NameProduit: (produit ["nom"] as? String)!, CategorieProduit: (categ_prod["nom"] as? String)!, idCatProd: (categ_prod["id"] as? NSInteger)!))
                }
                DispatchQueue.main.async {
                    self.CollectionViewList.reloadData()
                }}
            catch {
                print("cannot load from server")
            }}
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

