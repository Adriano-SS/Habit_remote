//
//  ProfileView.swift
//  Habit
//
//  Created by Adriano on 22/11/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disable: Bool {
        viewModel.birthdayValidation.failure ||
        viewModel.fullNameValidation.failure ||
        viewModel.phoneValidation.failure
    }
    
    var body: some View {
        ZStack {
            
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            }
            else {
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
                                    TextField("", text: $viewModel.email)
                                        .multilineTextAlignment(.trailing)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
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
                                    selectedGender: $viewModel.gender), label: {
                                        HStack{
                                            Text("Gênero")
                                            Spacer()
                                            Text(viewModel.gender?.rawValue ?? "")
                                        }
                                    })
                            }
                        }
                    }
                    .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.updateUser()
                    }, label: {
                        if case ProfileUIState.updateLoading = viewModel.uiState {
                            ProgressView()
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(.orange)
                        }
                        
                    })
                        .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)) {
                            Alert(
                                title: Text("Personal Habits"),
                                message: Text("Dados atualizados com sucesso"),
                                dismissButton: .default(Text("OK")){
                            })
                        }
                        .opacity(disable ? 0 : 1)
                    )
                }
            }
            
            if case ProfileUIState.fethcError(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(
                            title: Text("Personal Habits"),
                            message: Text(error),
                            dismissButton: .default(Text("OK")){
                        })
                    }
                    .background(Color.red)
            }
            
            if case ProfileUIState.updateError(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(
                            title: Text("Personal Habits"),
                            message: Text(error),
                            dismissButton: .default(Text("OK")){
                                viewModel.uiState = .none
                        })
                    }
                    .background(Color.red)
            }
            
        }.onAppear(perform: viewModel.fetchUser)
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
    }
}
