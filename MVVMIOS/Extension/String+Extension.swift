//
//  String+Extension.swift
//  MVVMIOS
//
//  Created by Ravi Bastola on 2/4/22.
//

import Foundation

extension String {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
