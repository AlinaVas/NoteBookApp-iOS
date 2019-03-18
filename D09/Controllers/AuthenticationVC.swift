//
//  FirstViewController.swift
//  D09
//
//  Created by Alina FESYK on 1/26/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationVC: UIViewController {

    let context = LAContext()
    
    override func loadView() {
        super.loadView()
        
        // set background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "launchImg")
        backgroundImage.contentMode = .scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // authenticate user
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "You need to be authorized") { [unowned self]
                (success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.performSegue(withIdentifier: "toHome", sender: self)
                    }
                    else {
                        print(error!.localizedDescription)
                    }
                }
            }
        }
    }
}

