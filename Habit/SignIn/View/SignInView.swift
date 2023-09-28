//
//  SignInView.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel  
    
    @State var email: String = ""
    @State var password: String = ""
    
    //variavel desnecessaria com navigationLink(value, label)
    //@State var action: Int? = 0
    
    @State var navigationHidden: Bool = true
    
    var body: some View {
        ZStack{
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            }
            else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20){
                            
                            Spacer(minLength: 36)
                            
                            VStack(alignment: .center, spacing: 8){
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .font(.system(.title).bold())
                                    .background(Color.white)
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                
                                
                                Text("@Copyright 2023")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 16).bold())
                                    .padding(.top, 16)
                            }
                        }
                        if case SignInUIState.error(let value) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)){
                                    Alert(title: Text("Personal Habits"), message: Text(value), dismissButton: .default(Text("OK")){
                                        //acao ao fechar o botao
                                    })
                                }
                                .background(Color.red)
                        }
                    }
                    //.frame(minWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .background(Color.white)
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(navigationHidden)//falsa por padrao
                }
                //maneira mais clara de esconder o titulo da barra
                .onAppear{
                    self.navigationHidden = true
                }
                .onDisappear{
                    self.navigationHidden = false
                }
            
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        TextField("", text: $email)
            .border(.black)
            .padding(.bottom, 8)    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("", text: $password)
            .border(.black)
        
    }
}

extension SignInView {
    var enterButton: some View {
        Button("Entrar", action: {
            viewModel.login(email: email, password: password)
            //nada a fazer por agora
        })
        .font(.system(.title3).bold())
        .padding(.bottom, 30)    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda nao possui login?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            ZStack {
                /*NavigationLink(
                 destination: SplashViewRouter.makeSignUpView(),
                 tag: 1,
                 selection: $action,
                 label: {EmptyView()})*/
                NavigationLink {
                    viewModel.signUpView()
                }
                label: {
                    Text("Realize seu cadastro")
                }
            }
            .padding(.bottom, 30)
        }
    }
        
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel()
        SignInView(viewModel: viewModel)
    }
}
