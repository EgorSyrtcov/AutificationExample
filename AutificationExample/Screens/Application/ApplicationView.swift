//
//  ApplicationView.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 14.02.22.
//

import SwiftUI

struct ApplicationView: View {
    
    @StateObject private var vm = ApplicationViewModel()
    
    var body: some View {
        
        ZStack {
            //background
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            if vm.userSession.currentUserSignedIn {
                Main()
            } else {
                Login()
            }
        }
    }
}

struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView()
    }
}
