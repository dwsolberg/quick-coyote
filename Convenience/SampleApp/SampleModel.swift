//
//  SampleModel.swift
//  Convenience
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

struct SampleModel {
    let name: String
    let vcClass: AnyClass
}

let items: [SampleModel] = [
    SampleModel(name: "UIViewController+Alert.swift", vcClass: AlertTestVC.self),
]

func test() {
    let model = items.first!
    let name = NSStringFromClass(model.vcClass)
    
}
