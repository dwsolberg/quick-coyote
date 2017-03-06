//
//  ViewController.swift
//  Convenience
//
//  Created by David Solberg on 2/19/17.
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

class AlertTestVC: UIViewController {

    @IBOutlet weak var textFieldAlertTitle: UITextField!

    @IBOutlet weak var textFieldDismissButtonTitle: UITextField!

    @IBOutlet weak var textFieldAcceptButtonTitle: UITextField!

    @IBOutlet weak var textFieldCancelButtonTitle: UITextField!

    @IBOutlet weak var labelResult: UILabel!

    @IBAction func userPressedMakeAlertButton(_ sender: Any) {
        guard let title = textFieldAlertTitle.text, title.characters.count > 0 else {
            presentAlert(withTitle: "No title", message: "Alerts must have a title!")
            return
        }

        if let dismiss = textFieldDismissButtonTitle.text, dismiss.characters.count > 0 {
            presentAlert(withTitle: title, message: "Test message.", dismissTitle: dismiss, dismissAction: { [unowned self] in
                self.labelResult.text = dismiss
                self.labelResult.accessibilityValue = dismiss
            })
        } else {
            presentAlert(withTitle: title, message: "Test message.", dismissAction: { [unowned self] in
                self.labelResult.text = "Used default dismiss"
                self.labelResult.accessibilityValue = "Used default dismiss"
            })
        }
    }

    @IBAction func userPressedMakeActionAlertButton(_ sender: Any) {

        guard let title = textFieldAlertTitle.text, title.characters.count > 0,
            let acceptTitle = textFieldAcceptButtonTitle.text, acceptTitle.characters.count > 0,
            let cancelTitle = textFieldCancelButtonTitle.text, cancelTitle.characters.count > 0
        else {
            presentAlert(withTitle: "Elements Missing", message: "Action alerts must have all elements filled in: title, accept title, and cancel title.")
            return
        }

        presentAlert(withTitle: title, message: "This is a test action alert",
                     acceptTitle: acceptTitle, acceptAction: { [unowned self] in
            self.labelResult.text = acceptTitle
            self.labelResult.accessibilityValue = acceptTitle
        }, cancelTitle: cancelTitle, cancelAction: {  [unowned self] in
            self.labelResult.text = cancelTitle
            self.labelResult.accessibilityValue = cancelTitle
        })


    }

}

