//
//  LoginViewModel.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 14.02.22.
//

import SwiftUI
import Combine

enum StorageKeys: String {
    case email, signed_in, token
}

final class LoginViewModel: ObservableObject {
    
    @Published var onboardingState: Int = 0
    
    @Published var email: String = ""
    @Published var textFieldStateEmail: StandardTextField.CurrentState = .error
    @Published var isValidEmain = false
    
    @Published var password: String = ""
    @Published var textFieldsStatePassword: StandardTextField.CurrentState = .error
    @Published var isSecureEntry: Bool = true
    @Published var isValidPassword = false
    
    @Published var alertTitle: String = ""
    @Published var showAlert: Bool = false
    
    //App Storage
    @Published var userSession = UserSession.shared
    
    // MARK: Private
    private var subscriptions = [AnyCancellable]()
    private let validator = Validator()
    
    // MARK: - API
    func becomeActive() {
        startSubscriptions()
    }
    
    func handleNextButtonPressed() {
        
        switch onboardingState {
        case 1:
            if !isValidEmain {
                showAlert(title: "Please enter a valid email address. 😧")
                return
            }
        case 2:
            guard password.count >= 6 else {
                showAlert(title: "Your password must be at least 6 characters long! 😧")
                return
            }
        default:
            break
        }
        
        
        //Go to next section
        if onboardingState == 2 {
            signIn()
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
    }
    
    private func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    private func signIn() {
        
        userSession.currentEmail = email
        userSession.currentToken = ""
        userSession.currentUserSignedIn = true
        
        //        withAnimation(.spring()) {
        //            currentUserSignedIn = true
        //        }
        
        
        //        WebService().login(email: email, password: password) { result in
        //            switch result {
        //            case .success(let token):
        //                print(token)
        //
        //                currentEmail = email
        //                currentToken = token
        //                withAnimation(.spring()) {
        //                    currentUserSignedIn = true
        //                }
        //
        //            case .failure(let error):
        //                print(error)
        //            }
        //        }
        
    }
}

// MARK: - Helpers
private extension LoginViewModel {
    
    func startSubscriptions() {
        $email
            .sink(
                receiveValue: { [weak self] value in
                    self?.validate(email: value)
                }
            )
            .store(in: &subscriptions)
        
        $password
            .sink(
                receiveValue: { [weak self] value in
                    self?.validate(password: value)
                }
            )
            .store(in: &subscriptions)
    }
    
    func validate(email: String) {
        isValidEmain = validator.isValid(email, of: .email)
        textFieldStateEmail = isValidEmain ? .inactive : .error
    }
    
    func validate(password: String) {
        isValidPassword = validator.isValid(password, of: .password)
        textFieldsStatePassword = isValidPassword ? .inactive : .error
    }
}
