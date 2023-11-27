//
//  ProfileView.swift
//  Habit
//
//  Created by Adriano on 22/11/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    
    @State var email = "adriano@gmail.com"
    @State var cpf = "111.111.111-11"
    
    
    @State var selectedGender: Gender? = .male
    
    var disable: Bool {
        viewModel.birthdayValidation.failure ||
        viewModel.fullNameValidation.failure ||
        viewModel.phoneValidation.failure
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Form {
                    Section(header: Text("Dados Cadastrais")) {
                        HStack {
                            Text("Nome")
                            Spacer()
                            TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        if viewModel.fullNameValidation.failure {
                            Text("Nome deve ter mais que 4 letras")
                                .foregroundColor(.red)
                        }
                        
                        
                        HStack {
                            Text("E-mail")
                            Spacer()
                            TextField("", text: $email)
                                .multilineTextAlignment(.trailing)
                                .disabled(true)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
                                .multilineTextAlignment(.trailing)
                                .disabled(true)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Text("Celular")
                            Spacer()
                            TextField("Digite o seu celular", text: $viewModel.phoneValidation.value)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        if viewModel.phoneValidation.failure {
                            Text("Entre com o DDD + 8 ou 9 dígitos")
                                .foregroundColor(.red)
                        }
                        
                        HStack {
                            Text("Data de Nascimento")
                            Spacer()
                            TextField("Digite a sua data de nascimento", text: $viewModel.birthdayValidation.value)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        if viewModel.birthdayValidation.failure {
                            Text("Use o formato: dd/MM/aaaa")
                                .foregroundColor(.red)
                        }
                        
                        NavigationLink(destination: GenderSelectionView(
                            title: "Escolha o gênero",
                            genders: Gender.allCases,
                            selectedGender: $selectedGender), label: {
                                HStack{
                                    Text("Gênero")
                                    Spacer()
                                    Text(selectedGender?.rawValue ?? "")
                                }
                            })
                    }
                }
            }
            .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {}, label: {Image(systemName: "checkmark")
                    .foregroundColor(.orange)
            })
                .opacity(disable ? 0 : 1)
            )
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
