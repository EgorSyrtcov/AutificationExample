//
//  Validator.swift
//  GPS Tracking App
//
//  Created by Egor Syrtcov on 14.02.22.
//

import Foundation

enum ValidationType {
    case password
    case email
}

struct Validator {
    func isValid(_ string: String?, of: ValidationType) -> Bool {
        switch of {
        case .email:
            if let string = string {
                let permissions = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                return permissions.evaluate(with: string)
            }
            return false

        case .password:
            //We check if password contains one big letter, one number and and is minimum eight char long.
            if let string = string {
                return !string.isEmpty
//                let permissions = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
//                return permissions.evaluate(with: string)
            }
            return false
        }
    }
}
