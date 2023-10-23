//
//  SignInView.swift
//  Habit
//
//  Created by Adriano on 9/20/23.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel    
    
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
                                    .foregroundColor(Color("textColor"))
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                
                                
                                Text("@Copyright - Adriano Soares 2023")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 13).bold())
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
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
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
        EditTextView( placeholder: "E-mail",
                      text: $viewModel.email,
                      keyboard: .emailAddress,
                      error: "E-mail invalido!",
                      failure: !viewModel.email.isEmail())
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView( placeholder: "Password",
                      text: $viewModel.password,
                      error: "A senha deve ter 8 caracteres!",
                      failure: viewModel.password.count < 8,
                      isSecure: true)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(
            action: { viewModel.login()},
            text: "Entrar",
            showProgress: self.viewModel.uiState == SignInUIState.loading,
            disable: !viewModel.email.isEmail() || viewModel.password.count < 8
            )
        }
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
        ForEach(ColorScheme.allCases, id: \.self) {
            let viewModel = SignInViewModel(interactor: SignInInteractor())
            SignInView(viewModel: viewModel)
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
