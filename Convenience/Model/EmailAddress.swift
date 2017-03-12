//
//  EmailAddress.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit
import MessageUI

typealias EmailAddressCompletion = (_ result: MFMailComposeResult?) -> Void

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
        guard EmailAddress.validate(unvalidated) else { return nil }
    }

    func sendFromViewController(_ vc: UIViewController, subject: String? = nil, message: String? = nil, isHtml: Bool = false, completion: EmailAddressCompletion? = nil) {

        guard MFMailComposeViewController.canSendMail() == true else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "mailto:")!, options: [:], completionHandler: { _ in })
            } else {
                UIApplication.shared.openURL(URL(string: "mailto:")!)
            }
            completion?(nil)
            return
        }

        let mailer = MFMailComposeViewController()
        mailer.setToRecipients([combinedAddress])

        if let subject = subject { mailer.setSubject(subject) }
        if let message = message { mailer.setMessageBody(message, isHTML: isHtml) }

        mailer.mailComposeDelegate = self
        EmailAddress.retainedInstance = self
        self.presentingVC = vc
        self.completion = completion

        vc.present(mailer, animated: true) { () -> Void in  }
    }

    static func validate(_ potentialAddress: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: potentialAddress)
    }

    // MARK: - Internal

    // We're holding onto these variables because the user may not always want to store them in a variable. This allows us to keep
    private weak var presentingVC: UIViewController?
    private var completion: EmailAddressCompletion?
    private static var retainedInstance: EmailAddress?

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        if let presentingVC = self.presentingVC {
            presentingVC.dismiss(animated: true, completion: { [weak self] () -> Void in
                defer { EmailAddress.retainedInstance = nil }
                guard let strong = self else { return }
                strong.presentingVC = nil
                strong.completion?(result)
                strong.completion = nil
            })
        } else {
            EmailAddress.retainedInstance = nil
            completion?(result)
        }
    }
}
