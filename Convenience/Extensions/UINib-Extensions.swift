//
//  UINib-Extensions.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

/// Any xib file can conform to this protocol *if* the nib file has the same name as the view's class. Just add it to the end of any class, eg. MyCell: UITableViewCell, NibCreatable
protocol NibCreatable {
    associatedtype Instance
    static func instanceFromNib() -> Instance?
}


extension NibCreatable where Self: UIView {

    /// Pulls out the top level view from the nib file and returns it if it has the same class. If there is no view, this method will crash.
    static func instanceFromNib() -> Self? {
        guard let instance = UINib.viewForName(self.baseClassName) as? Self
        else { return nil }
        return instance
    }
}

fileprivate extension NSObject {
    /// Swift adds a namespace to the class. For example, MyClass would be called ProjectName.MyClass. This extension pulls out just the MyClass so that it will match the nib's name.
    fileprivate static var baseClassName: String! {
        let namespacedClassName = NSStringFromClass(self) as NSString
        let baseClassName = namespacedClassName.components(separatedBy: ".").last
        return baseClassName!
    }
}

// MARK: - Private

extension UINib {
    /// Get the root level view in a nib file. Will crash if the nib file is empty or does not exist.
    fileprivate static func viewForName(_ name : String) -> UIView {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        let view = views?.first
        return view! as! UIView
    }
}
