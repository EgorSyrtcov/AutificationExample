//
//  Login.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 14.02.22.
//

import SwiftUI

struct Login: View {
    
    @StateObject private var vm = LoginViewModel()
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    var body: some View {
        ZStack {
            //content
            ZStack {
                switch vm.onboardingState {
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    addEmailSection
                        .transition(transition)
                case 2:
                    addPasswordSection
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.green)
                }
            }
            
            //buttons
            VStack {
                Spacer()
                
                bottomButton
            }
            .padding(30)
        }
        .alert(isPresented: $vm.showAlert, content: {
            return Alert(title: Text(vm.alertTitle))
        })
        .onAppear {
            vm.becomeActive()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .background(Color.purple)
    }
}

//MARK: COMPONENTS
extension Login {
    
    private var bottomButton: some View {
        Text(vm.onboardingState == 0
             ? "SIGN UP"
             : vm.onboardingState == 2 ? "Finish" : "NEXT")
            .font(.headline)
            .foregroundColor(.purple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                vm.handleNextButtonPressed()
            }
    }
    
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            Text("Registration Form")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding(50)
    }
    
    private var addEmailSection: some View {
        VStack(spacing: 40) {
            
            Text("Enter your email")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            StandardTextField(
                title: "Email",
                state: $vm.textFieldStateEmail,
                text: $vm.email,
                leadingIconImage: UIImage(named: "mail")
            )
                .frame(height: 56, alignment: .leading)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding()
        .padding(.bottom, 100)
    }
    
    private var addPasswordSection: some View {
        VStack(spacing: 40) {
            
            Text("Enter your password")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            StandardTextField(
                title: "Password",
                state: $vm.textFieldsStatePassword,
                text: $vm.password,
                leadingIconImage: UIImage(
                    named: "lock"
                ),
                showPasswordBtn: true,
                isSecureEntry: $vm.isSecureEntry
            )
                .foregroundColor(.black)
                .frame(height: 56, alignment: .leading)
                .autocapitalization(.none)
        }
        .padding()
        .padding(.bottom, 100)
    }
    
}
