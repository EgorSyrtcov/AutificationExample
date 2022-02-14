//
//  LoginRequestBody.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 14.02.22.
//

import Foundation

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}
