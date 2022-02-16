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
    @Published var userSession = UserSession.shared
    
    func signOut() {
        userSession.currentEmail = nil
        userSession.currentToken = nil
        withAnimation(.spring()) {
            userSession.currentUserSignedIn = false
        }
    }
}
