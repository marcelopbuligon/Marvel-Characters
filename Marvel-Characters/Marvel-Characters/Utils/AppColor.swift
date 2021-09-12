//
//  AppColor.swift
//  Marvel-Characters
//
//  Created by Marcelo Pagliarini Buligon on 11/09/21.
//

import UIKit

enum AppColor: String {
    case shadow
    
    var color: UIColor { return UIColor(named: rawValue) ?? .black }
    var cgColor: CGColor { return color.cgColor }
}
