//
//  SplashView.swift
//  Habit
//
//  Created by user246507 on 9/16/23.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    var body: some View {
        VStack{
            Group {
                switch viewModel.uiState{
                    case .loading:
                        loadingView()
                    case .goToSignInScreen:
                        viewModel.signInView()                    
                    case .goToHomeScreen:
                    viewModel.homeView()
                    case .error(let msg):
                        loadingView(error: msg)
                }
            }.onAppear(perform: {
                viewModel.onApperar()
            })        }
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
        let viewModel = SplashViewModel()
        SplashView(viewModel: viewModel)
    }
}
