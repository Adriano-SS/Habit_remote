//
//  SignUpView.swift
//  Habit
//
//  Created by Adriano on 9/20/23.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel   
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        emailField
                        passwordField
                        documentField
                        phoneField
                        birthdayField
                        genderField
                        saveButton
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }.padding()
            
            /*if case SignUpUIState.success(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Personal Habits"), message: Text(value), dismissButton: .default(Text("OK")){
                            //acao ao fechar o botao
                        })
                    }
                    .background(Color.green)                
                    viewModel.loginView()
            }*/
            
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Personal Habits"), message: Text(value), dismissButton: .default(Text("OK")){
                            //acao ao fechar o botao
                        })
                    }
                    .background(Color.red)
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(placeholder: "Nome completo", text: $viewModel.fullName, keyboard: .alphabet, error: "Nome deve ter mais que 4 letras", failure: viewModel.fullName.count < 4)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView( placeholder: "E-mail",
                      text: $viewModel.email,
                      keyboard: .emailAddress,
                      error: "E-mail invalido!",
                      failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView( placeholder: "Password",
                      text: $viewModel.password,
                      error: "A senha deve ter 8 caracteres!",
                      failure: viewModel.password.count < 8,
                      isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(placeholder: "CPF", text: $viewModel.document, keyboard: .numberPad, error: "CPF deve conter 11 numeros!", failure: viewModel.document.count != 11)
        
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(placeholder: "Celular", text: $viewModel.phone, keyboard: .phonePad, error: "Entre com o DDD + 8 ou 9 dígitos", failure: viewModel.phone.count < 10 || viewModel.phone.count > 11)
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(placeholder: "Data de nascimento", text: $viewModel.birthday, keyboard: .numberPad, error: "Use o formato: dd/MM/aaaa", failure: viewModel.birthday.count != 10)    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }
        .border(.black)
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top, 16)
        .padding(.bottom, 32)       
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(
            action: { viewModel.signUp()},
            text: "Realize seu cadastro",
            showProgress: self.viewModel.uiState == SignUpUIState.loading,
            disable: !viewModel.email.isEmail() || viewModel.password.count < 8
            )
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            let viewModel = SignUpViewModel()
            SignUpView(viewModel: viewModel)
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
