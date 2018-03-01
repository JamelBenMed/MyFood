//
//  ContactUsViewController.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit
import Alamofire

class ContactUsViewController: BaseMenuViewController {

    @IBOutlet weak var secondView: UIViewX!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var txtTitle: UITextFieldX!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buSend(_ sender: Any) {
        if (txtTitle.text == ""){
            txtTitle.becomeFirstResponder()
            self.showAlertWith(msg: Constants.Messages.Contact_MessageTitle)
        }
        else if (txtMessage.text == Constants.PlaceHolder.Contact_TextView){
            txtMessage.becomeFirstResponder()
            self.showAlertWith(msg: Constants.Messages.Contact_MessageContent)
        }
        else{
            
            var requestParams: Dictionary<String, String> = [:]
            requestParams[Constants.KEY.CONTACT.TITLE] = txtTitle.text
            requestParams[Constants.KEY.CONTACT.MESSAGE] = txtMessage.text
              let url = Constants.URLs.PREFIX_URL+Constants.URLs.CONTATCT_ADMIN
            DataHelper.sharedInstance.alamofireManager().request(url, method: .post, parameters: requestParams, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(let JSON):
                    if  let response = JSON as? NSDictionary{
                        
                        if let isSuccess = response.object(forKey: "success") as? Bool{
                            if (isSuccess == true){
                                let alert = UIAlertController(title: Constants.Messages.POP_UP_TITLE, message: Constants.Messages.CONTACT_SUCCESS, preferredStyle: .alert)
                                let yesButton = UIAlertAction(title:  Constants.Messages.POP_UP_OK_BTN, style: .default, handler: {(_ action: UIAlertAction) -> Void in
                                    self.btnBack(self.btnBack)
                                })
                                alert.addAction(yesButton)
                                self.present(alert, animated: true)
                                
                            }
                            else{
                                if let msg = response.object(forKey: "message") as? String{
                                    self.showAlertWith(msg:msg)
                                }
                                else{
                                    self.showAlertGeneralError()
                                    
                                }
                            }
                            
                        }
                        else{
                            
                            self.showAlertGeneralError()
                            
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
    func textViewDidBeginEditing(_ textView: UITextView){
        textView.text = ""
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView){
        if (textView.text == ""){
            textView.text = Constants.PlaceHolder.Contact_TextView
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

