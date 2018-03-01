//
//  RegisterViewController.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.

import UIKit
import Alamofire

class RegisterViewController: BasePopupViewController,UITextFieldDelegate {

    @IBAction func butRegistre(_ sender: UIButton) {
        if (self.checkIfFieldsAreFilled()){
            
            var requestParams: Dictionary<String, String> = [:]
            
            requestParams[Constants.KEY.UPDATE.USERNAME] = txtUsername.text
            requestParams[Constants.KEY.UPDATE.NOM] = txtNom.text
            requestParams[Constants.KEY.UPDATE.PRENOM] = txtPrenom.text
            requestParams[Constants.KEY.UPDATE.TEL] = txtNumTel.text
            requestParams[Constants.KEY.UPDATE.EMAIL] = txtEmail.text
            requestParams[Constants.KEY.UPDATE.PASSWORD] = txtPassword.text

            print("requestParams  \(requestParams.description)")
            
            let url = Constants.URLs.PREFIX_URL+Constants.URLs.SIGN_UP
            
            DataHelper.sharedInstance.alamofireManager().request(url, method: .post, parameters: requestParams, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
                print("JSON  \(response)")
                
                switch(response.result) {
                case .success(let JSON):
                    if  let response = JSON as? NSDictionary{
                        if let success = response.object(forKey: "succes") as? Bool{
                            if (success == true){
                                if let message = response.object(forKey: "message") as? String {
                                    let alert = UIAlertController(title: Constants.Messages.POP_UP_TITLE, message: message, preferredStyle: .alert)
                                    let oKBtn = UIAlertAction(title:  Constants.ButtonTitle.OK, style: .default, handler: {(_ action: UIAlertAction) -> Void in
                                        self.dismiss(animated: true, completion: {
                                            var isSuccess = false
                                            if (self.delegate != nil){
                                             if let dic  = response.object(forKey: "user") as? NSDictionary, let user = User(dic: dic) as? User{
                                                    isSuccess = true
                                                    DataHelper.sharedInstance.user = user
                                                }
                                            }
                                            if (isSuccess == false){
                                                self.delegate.showAlertGeneralError()
                                            }
                                        })
                                    })
                                    
                                    alert.addAction(oKBtn)
                                    
                                    self.present(alert, animated: true)
                                }
                                else{
                                    self.showAlertGeneralError()
                                }
                                
                            }
                            else{
                                if let message = response.object(forKey:"message") as? String {
                                    self.showAlertWith(msg: message)
                                }
                                else{
                                    self.showAlertGeneralError()
                                }
                            }
                        }
                            else
                                {
                                self.showAlertWith(msg: Constants.Messages.PROFILE_UPDATE_FAILED)
                                
                        }
                        }
                            
                        else{
                            self.showAlertGeneralError()
                        }
                        break
                        
                        case .failure(let error):
                        
                        print("JSON  \(error)")
                        self.showAlertWith(msg:error.localizedDescription)
                        
                        break
                            
                        }
                    }
                }
            }

           
        
     /*   let username = txtUsername.text
        let password = txtPassword.text
        let mail = txtEmail.text
        let nom = txtNom.text
        let prenom = txtPrenom.text
        let tel = txtNumTel.text

        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(mail, forKey: "mail")
        UserDefaults.standard.set(tel, forKey: "tel")
        UserDefaults.standard.set(nom, forKey: "nom")
        UserDefaults.standard.set(prenom, forKey: "prenom")
        UserDefaults.standard.synchronize()
        let myAlert = UIAlertController (title: "Alerte", message: "تم التسجيل بنجاح", preferredStyle: UIAlertControllerStyle.alert)
        let okAlert = UIAlertAction(title: "OK", style: UIAlertActionStyle.default ) { ACTION in
            self.dismiss(animated: true, completion: nil)
        }
        myAlert.addAction(okAlert)
        self.present(myAlert, animated: true, completion: nil)
     */

   
    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtNumTel: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPrenom: UITextField!
    @IBOutlet weak var txtNom: UITextField!
    
    var connectedUser = User()
    var delegate:UIViewController!
    
     func checkIfFieldsAreFilled()->Bool{
        if ((txtUsername.text == "") || (txtPassword.text == "") || (txtEmail?.text == "") || (txtNom?.text == "") || (txtPrenom?.text == "") || (txtNumTel.text == ""))
        {
            displaymyalertmessage(usermessage: "يجب تعمير كافة الخانات")
            return false
        }
        if(txtEmail.text?.checkIfEMailWithCorrectFormat() == false){
            self.showAlertWith(msg: Constants.Messages.EMAIL_INCORRECT_FORMAT)
            return false
        }
        return true
        }
    
    func displaymyalertmessage(usermessage: String) {
        let myAlert = UIAlertController (title: "Alerte", message: usermessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAlert = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAlert)
        self.present(myAlert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
}
