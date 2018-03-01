//
//  UpdateViewController.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit
import Alamofire

class UpdateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    func setFieldEnableWith(isEnable:Bool){
        for textField in uiViewX.subviews {
         if(textField.isKind(of: UITextField.self)){
                ( textField as! UITextField) .isEnabled = isEnable
                ( textField as! UITextField).textColor = isEnable == true ? UIColor.blackMyFood() : UIColor.grayMyFood()
            }
        }
    }
    var connectedUser = User()
    private var isEnableEditing = false
    @IBOutlet weak var buUpdate: UIButton!
    @IBOutlet var uiViewX: UIView!
   
    @IBAction func buUpdate(_ sender: Any) {
        
        if(isEnableEditing  == false){
        isEnableEditing = true
        
        self.buUpdate.setTitle(Constants.ButtonTitle.Save, for: .normal)
            self.setFieldEnableWith(isEnable: isEnableEditing)
            
        }
            else{
                if (txtNomU.text == ""){
                    txtNomU.becomeFirstResponder()
                    self.showAlertWith(msg: Constants.Messages.NAME_WORD_REQUIRED)
                }
                else if (txtEmailU.text?.checkIfEMailWithCorrectFormat() == false){
                    txtEmailU.becomeFirstResponder()
                    self.showAlertWith(msg: Constants.Messages.EMAIL_INCORRECT_FORMAT)
                }
                else if (txtPrenomU.text == ""){
                    txtPrenomU.becomeFirstResponder()
                    self.showAlertWith(msg: Constants.Messages.LAST_NAME_WORD_REQUIRED)
                }
                else if (txtNumTelU.text == ""){
                    txtNumTelU.becomeFirstResponder()
                    self.showAlertWith(msg: Constants.Messages.PHONNUMBER_REQUIRED)
                }
                else if (txtPasswordU.text == ""){
                    txtPasswordU.becomeFirstResponder()
                    self.showAlertWith(msg: Constants.Messages.PASS_WORD_REQUIRED)
            }
                else {
                    
                var requestParams: Dictionary<String, String> = [:]
                    requestParams[Constants.KEY.UPDATE.USERNAME] = connectedUser.userName
                    requestParams[Constants.KEY.UPDATE.EMAIL] = connectedUser.mail
                    requestParams[Constants.KEY.UPDATE.TEL] = txtNumTelU.text
                    requestParams[Constants.KEY.UPDATE.TOKEN] = connectedUser.token
                    requestParams[Constants.KEY.UPDATE.PASSWORD] = txtPasswordU.text
                    requestParams[Constants.KEY.UPDATE.NOM] = connectedUser.name
                    requestParams[Constants.KEY.UPDATE.PRENOM] = connectedUser.prenom
                    
                    print("requestParams  \(requestParams.description)")
                    
                    let url = Constants.URLs.PREFIX_URL+Constants.URLs.UPDATE_PROFILE
                    
                    DataHelper.sharedInstance.alamofireManager().request(url, method: .post, parameters: requestParams, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
                        print("JSON  \(response)")
                    switch(response.result) {
                        case .success(let JSON):
                            if  let response = JSON as? NSDictionary{
                                print("JSON  \(response)")
                                if let error = response.object(forKey: "code_error") as? String{
                                    print(error)
                                    self.showAlertWith(msg: Constants.Messages.PROFILE_UPDATE_FAILED)
                                }
                                else if let id = response.object(forKey: "id") as? Int64{
                                    print(id)
                                    DataHelper.sharedInstance.user = User(dic: response)
                                    self.showAlertWith(msg: Constants.Messages.PROFILE_UPDATE_SUCCESS)
                                }
                                else{
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
    }
    @IBOutlet weak var txtNumTelU: UITextField!
    @IBOutlet weak var txtEmailU: UITextField!
    @IBOutlet weak var txtPasswordU: UITextField!
    @IBOutlet weak var txtPrenomU: UITextField!
    @IBOutlet weak var txtNomU: UITextField!
    @IBOutlet weak var txtUserNameU: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initDataWith(user:User){
        connectedUser = user
        txtNomU.text = user.name
        txtPrenomU.text = user.prenom
        txtEmailU.text = user.mail
        txtUserNameU.text = user.userName
        txtPasswordU.text = DataHelper.sharedInstance.returnPassword()
        txtNumTelU.text = user.tel
        
        isEnableEditing = false
        self.setFieldEnableWith(isEnable: isEnableEditing)
        self.buUpdate.setTitle(Constants.ButtonTitle.Edit, for: .normal)
      
            
    }
    
    

}


