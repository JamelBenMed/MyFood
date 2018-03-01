//
//  LoginPopupViewController.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
import UIKit
import Alamofire

class LoginPopupViewController: BasePopupViewController,UITextFieldDelegate {

    @IBAction func buLogin(_ sender: UIButton) {
        if (self.checkIfFieldsAreFilled()){
            var requestParams: Dictionary<String, String> = [:]
            requestParams[Constants.KEY.LOGIN.USERNAME] = txtUserName.text
            requestParams[Constants.KEY.LOGIN.PASSWORD] = txtPassword.text
            let url = Constants.URLs.PREFIX_URL+Constants.URLs.LOGIN
            DataHelper.sharedInstance.alamofireManager().request(url, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                switch(response.result) {
                case .success(let JSON):
                    print("JSON  \(JSON)")
                    if   let response = JSON as? NSDictionary{
                        if let codeError = response.object(forKey: "code_error") as? String{
                            print(codeError)
                            self.showAlertGeneralError()
                            
                        }
                        else{
                            UserDefaults.standard.set(self.txtPassword.text, forKey: Constants.UserDefault.PassWord)
                            DataHelper.sharedInstance.user = User(dic: response)
                            self.navigationController?.popViewController(animated: true)
                            
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
    
    
  func checkIfFieldsAreFilled()->Bool{
        if(txtUserName.text == ""){
            txtUserName.becomeFirstResponder()
            self.showAlertWith(msg: Constants.Messages.USERNAME_WORD_REQUIRED)
            return false
        }
        if(txtPassword.text == ""){
            txtPassword.becomeFirstResponder()
            self.showAlertWith(msg: Constants.Messages.PASS_WORD_REQUIRED)
            return false
        }
        return true
    }

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(Utils.isAppInProdState() == false){
            txtUserName.text = "USER3"
            txtPassword.text = "USER4"
        }
}
    func returnCurrentTextField()->UITextField{
        if(txtPassword.isFirstResponder){
            return txtPassword
        }
        return txtUserName
    }
    
}
