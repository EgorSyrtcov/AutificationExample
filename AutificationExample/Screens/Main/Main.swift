//
//  Main.swift
//  AutificationExample
//
//  Created by Egor Syrtcov on 14.02.22.
//

import SwiftUI

struct Main: View {
    
    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        VStack {
            Text("Main screen")
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text(vm.currentEmail ?? "Your email here")
            
            Text("SIGN OUT")
                .foregroundColor(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10)
                .onTapGesture {
                    vm.signOut()
                }
            
        }
        .font(.title)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
