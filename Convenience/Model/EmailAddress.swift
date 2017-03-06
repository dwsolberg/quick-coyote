//
//  EmailAddress.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit
import MessageUI

// Hold an email address with a display name and provides a way to send an email.
class EmailAddress: NSObject, MFMailComposeViewControllerDelegate {

    let address: String
    let displayName: String?

    var combinedAddress: String {
        guard let displayName = displayName else { return address }
        return displayName + "<" + address + ">"

    }

    init?(address unvalidated: String, displayName: String? = nil) {
        self.address = unvalidated
        self.displayName = displayName
        super.init()
        guard unvalidated.isProbablyEmailAddress else { return nil }
    }

    func sendFromViewController(_ vc: UIViewController, subject: String? = nil, message: String? = nil, isHtml: Bool = false) -> Bool {

        guard MFMailComposeViewController.canSendMail() == true else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "mailto:")!, options: [:], completionHandler: { _ in })
            } else {
                UIApplication.shared.openURL(URL(string: "mailto:")!)
            }
            return false
        }

        let mailer = MFMailComposeViewController()
        mailer.setToRecipients([combinedAddress])

        if let subject = subject { mailer.setSubject(subject) }
        if let message = message { mailer.setMessageBody(message, isHTML: isHtml) }

        mailer.mailComposeDelegate = self
        EmailAddress.retainedInstance = self
        presentingVC = vc

        vc.present(mailer, animated: true) { () -> Void in  }
        return true
    }

    // MARK: - Internal

    // We're holding onto these variables because the user may not always want to store them in a variable. This allows us to keep
    private weak var presentingVC: UIViewController?
    private static var retainedInstance: EmailAddress?

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        if let presentingVC = self.presentingVC {
            presentingVC.dismiss(animated: true, completion: { [weak self] () -> Void in
                self?.presentingVC = nil
                EmailAddress.retainedInstance = nil
            })
        } else {
            EmailAddress.retainedInstance = nil
        }

    }
}

extension String {
    var isProbablyEmailAddress: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
