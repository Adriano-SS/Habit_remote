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
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Nome completo",
                     keyboard: .alphabet,
                     error: "Nome deve ter mais que 4 letras",
                     failure: viewModel.fullName.count < 4,
                     autocapitalization: .words)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView( text: $viewModel.email,
                      placeholder: "E-mail",
                      keyboard: .emailAddress,
                      error: "E-mail invalido!",
                      failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView( text: $viewModel.password,
                      placeholder: "Password",
                      error: "A senha deve ter 8 caracteres!",
                      failure: viewModel.password.count < 8,
                      isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "Entre com seu CPF",
                     mask: "###.###.###-##",
                     keyboard: .numberPad,
                     error: "CPF inválido!",
                     failure: viewModel.document.count != 14)
        
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Celular",
                     mask: "(##) ####-####",
                     keyboard: .phonePad,
                     error: "Entre com o DDD + 8 ou 9 dígitos",
                     failure: viewModel.phone.count < 14 || viewModel.phone.count > 15)
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Data de nascimento",
                     mask: "##/##/####",
                     keyboard: .numberPad,
                     error: "Use o formato: dd/mm/aaaa",
                     failure: viewModel.birthday.count != 10)    }
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
            action: {
                viewModel.signUp()
            },
            text: "Realize seu cadastro",
            showProgress: self.viewModel.uiState == SignUpUIState.loading,
            disable: !viewModel.email.isEmail() ||
            viewModel.password.count < 8 ||
            viewModel.fullName.count < 4 ||
            viewModel.document.count != 14 ||
            viewModel.phone.count < 14 || viewModel.phone.count > 15 ||
            viewModel.birthday.count != 10
        )
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            let viewModel = SignUpViewModel(intercator: SignUpInteractor())
            SignUpView(viewModel: viewModel)
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
