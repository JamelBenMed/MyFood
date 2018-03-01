

import UIKit

@IBDesignable
class UIViewControllerX: UIViewController {
    
    @IBAction func buRegister(_ sender: UIButton) {
    }
    
    
    @IBAction func buLogin(_ sender: UIButton) {
    }
    @IBInspectable var lightStatusBar: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            if lightStatusBar {
                return UIStatusBarStyle.lightContent
            } else {
                return UIStatusBarStyle.default
            }
        }
    }
}
