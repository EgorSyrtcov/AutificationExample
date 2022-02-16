//
//  ApplicationViewModel.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 16.02.22.
//

import SwiftUI
import Combine

final class ApplicationViewModel: ObservableObject {
    
    @Published var userSession = UserSession.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        updateUserSession()
        validationCheck()
    }
    
    private func validationCheck() {

        guard
            let currentToken = userSession.currentToken,
            !currentToken.isEmpty == true
        else {
            userSession.currentUserSignedIn = false
            userSession.currentEmail = nil
            return
        }

        // Request 
    }
}

extension ApplicationViewModel {
    
    private func updateUserSession() {
        userSession.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
