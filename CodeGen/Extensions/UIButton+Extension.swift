//
//  UIButton+Extension.swift
//  CodeGen
//
//  Created by Matt Thomas on 18/12/2022.
//

import UIKit

extension UIButton {
    
    func addBorder() {
        backgroundColor = .clear
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
