//
//  SplashView.swift
//  Habit
//
//  Created by user246507 on 9/16/23.
//

import SwiftUI

struct SplashView: View {
    @State var state: SplashUIState = .error("Perda de conexao com o servidor")
    //@State var state: SplashUIState = .loading
    var body: some View {
        switch state{
        case .loading:
            loadingView()
        case .goToSignInScreen:
            Text("Tela de login")
        case .goToHomeScreen:
            Text("Tela principal")
        case .error(let msg):
           loadingView(error: msg)
        }
    }
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .background(Color.white)
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Personal Habits"), message: Text(error), dismissButton: .default(Text("OK")){
                            //acao ao fechar o botao
                        })
                    }
                    .background(Color.red)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
