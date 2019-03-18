//
//  Extensions.swift
//  D09
//
//  Created by Alina Fesyk on 3/5/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
}
