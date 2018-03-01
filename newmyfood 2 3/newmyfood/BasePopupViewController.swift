//
//  BasePopupViewController.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import UIKit

class BasePopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2723921655)
        let dismissButton = UIButton(frame: view.frame)
        dismissButton.addTarget(self, action: #selector(dismissPopup(_:)), for: .touchUpInside)
//        view.addSubview(dismissButton)
        view.insertSubview(dismissButton, at: 0) // Behind other objects
    }
    
    @objc func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
