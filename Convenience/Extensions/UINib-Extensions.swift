//
//  UINib-Extensions.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

extension UINib {

    /// Get the root level view in a nib file. Will crash if the nib file is empty or does not exist.
    static func viewForName(_ name : String) -> UIView {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        let view = views?.first
        return view! as! UIView
    }
}

protocol NibCreatable {
    associatedtype Instance
    static func instanceFromNib() -> Instance?
}

extension NibCreatable where Self: UIView {
    static func instanceFromNib() -> Self? {
        guard let instance = UINib.viewForName(self.baseClassName) as? Self
        else { return nil }
        return instance
    }
}

extension NSObject {
    static var baseClassName: String! {
        let namespacedClassName = NSStringFromClass(self) as NSString
        let baseClassName = namespacedClassName.components(separatedBy: ".").last
        return baseClassName!
    }
}
