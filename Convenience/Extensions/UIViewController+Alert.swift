//
//  UIViewController+Alert.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

typealias AlertButtonPressAction = () -> Void

/// Convenience Methods to display an alert without all the boilerplate.
extension UIViewController
{
    func presentAlert(withTitle title: String, message: String, dismissTitle: String = "Dismiss", dismissAction: @escaping AlertButtonPressAction = {} ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissButtonAction = UIAlertAction(title: dismissTitle, style: .cancel) { (action) in
            dismissAction()
        }
        alert.addAction(dismissButtonAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(withTitle title: String, message: String, acceptTitle: String, acceptAction: @escaping AlertButtonPressAction = {}, cancelTitle: String, cancelAction: @escaping AlertButtonPressAction = {})
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            cancelAction()
        }
        alert.addAction(cancelAlertAction)
        let acceptAlertAction = UIAlertAction(title: acceptTitle, style: .default) { (action) -> Void in
            acceptAction()
        }
        alert.addAction(acceptAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
