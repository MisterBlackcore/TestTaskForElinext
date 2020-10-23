//
//  UIViewController+Alert.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/22/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertController(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
