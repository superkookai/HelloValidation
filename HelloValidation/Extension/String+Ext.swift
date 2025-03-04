//
//  String+Ext.swift
//  HelloValidation
//
//  Created by Weerawut Chaiyasomboon on 04/03/2568.
//

import Foundation

extension String {
    var isEmailValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
}
