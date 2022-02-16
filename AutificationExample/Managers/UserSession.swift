//
//  UserSession.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 16.02.22.
//

import SwiftUI

class UserSession: ObservableObject {
    
    static let shared = UserSession()

    @AppStorage(StorageKeys.signed_in.rawValue) var currentUserSignedIn: Bool = false {
        willSet { objectWillChange.send() }
    }
    
    @AppStorage(StorageKeys.email.rawValue) var currentEmail: String?
    @AppStorage(StorageKeys.token.rawValue) var currentToken: String?
}
