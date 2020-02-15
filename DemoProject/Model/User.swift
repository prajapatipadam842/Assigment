//
//  User.swift
//  DemoProject
//
//  Created by Padam on 15/02/20.
//  Copyright © 2020 Padam. All rights reserved.
//

import Foundation
import ObjectMapper
struct User: Mappable {
    var name: String?
    var image: String?
    var items: [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        name     <- map["name"]
        image     <- map["image"]
        items     <- map["items"]
    }
}
