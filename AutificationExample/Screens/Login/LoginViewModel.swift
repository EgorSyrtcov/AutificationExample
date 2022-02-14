//
//  LoginViewModel.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 14.02.22.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    
    @Published var onboardingState: Int = 0
    
    @Published var email: String = ""
    @Published var textFieldStateEmail: StandardTextField.CurrentState = .inactive
    @Published var isValidEmain = false
    
    @Published var password: String = ""
    @Published var textFieldsStatePassword: StandardTextField.CurrentState = .inactive
    @Published var isSecureEntry: Bool = true
    
    @Published var alertTitle: String = ""
    @Published var showAlert: Bool = false
    
    //App Storage
    @AppStorage("email") var currentEmail: String?
    @AppStorage("password") var currentPassword: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
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
        currentEmail = email
        currentPassword = password
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
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
    }

    func validate(email: String) {
        isValidEmain = validator.isValid(email, of: .email)
    }
}
