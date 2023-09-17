//
//  SplashView.swift
//  Habit
//
//  Created by user246507 on 9/16/23.
//

import SwiftUI

struct SplashView: View {
    @State var state: SplashUIState = .loading
    var body: some View {
        switch state{
        case .loading:
            Text("Carregando")
        case .goToSignInScreen:
            Text("Tela de login")
        case .goToHomeScreen:
            Text("Tela principal")
        case .error(let msg):
            Text("Erro:\n\(msg)")
        }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
