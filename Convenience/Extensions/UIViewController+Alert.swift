//
//  UIViewController+Alert.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

typealias ButtonPressAction = () -> Void

/// Convenience Methods to display an alert without all the boilerplate.
extension UIViewController
{
    func presentAlertWithTitle(_ title: String, message: String, dismissTitle: String = "Dismiss", completion: @escaping ButtonPressAction = {}){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: title, style: .cancel) { (action) in
            completion()
        }
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlertWithTitle(_ title: String, message: String, cancelTitle: String, cancelAction: @escaping ButtonPressAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            cancelAction()
        }
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlertWithTitle(_ title: String, message: String, acceptTitle: String, acceptAction: @escaping ButtonPressAction, cancelTitle: String, cancelAction: @escaping ButtonPressAction)
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
