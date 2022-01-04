//
//  ColorCode.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 23/08/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import UIKit

struct ColorCode<Base> {
    let base: Base
    
    init (_ base: Base) {
        self.base = base
    }
}

protocol ColorCodeCompatible {
    associatedtype ColorCodeType
    static var ex: ColorCode<ColorCodeType>.Type { get }
}

extension ColorCodeCompatible {
    static var ex: ColorCode<Self>.Type {
        return ColorCode<Self>.self
    }
}

extension UIColor: ColorCodeCompatible { }

extension ColorCode where Base: UIColor {
    
    static var yellow: UIColor {
        return UIColor(hex: "FDB813")
    }
    
    static var green: UIColor {
        return UIColor(hex: "00A64B")
    }
    
    static var gray: UIColor {
        return UIColor(hex: "dddddd")
    }
    
    static var darkGray: UIColor {
        return UIColor(hex: "5e5f60")
    }
    
    static var red: UIColor {
        return UIColor(hex: "ED1C24")
    }
    
    static var black: UIColor {
        return UIColor(hex: "101111")
    }
    
    static var blue: UIColor {
        return UIColor(hex: "006EB7")
    }
    static var orange: UIColor {
        return UIColor(hex: "e36f00")
    }
}
