//
//  MainViewModel.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 14.02.22.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    
    //App Storage
    @AppStorage("email") var currentEmail: String?
    @AppStorage("password") var currentPassword: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    func signOut() {
        currentEmail = nil
        currentPassword = nil
        withAnimation(.spring()) {
            currentUserSignedIn = false
        }
    }
}
