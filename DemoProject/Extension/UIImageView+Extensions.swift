//
//  UIImageView+Extensions.swift
//  DemoProject
//
//  Created by Padam on 15/02/20.
//  Copyright © 2020 Padam. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
extension UIImageView{
    func setImageFromURL(urlString:String) {
        self.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder"))
    }
}
