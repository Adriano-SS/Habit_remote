//
//  ProfileView.swift
//  Habit
//
//  Created by Adriano on 22/11/23.
//

import SwiftUI

struct ProfileView: View {
    @State var fullName = "Adriano Soares"
    @State var email = "adriano@gmail.com"
    @State var cpf = "111.111.111-11"
    @State var phone = "(83) 9999-9999"
    @State var birthday = "29/01/1983"
    @State var selectedGender: Gender? = .male
    
    var body: some View {
        NavigationView {
            
            VStack {
                Form {
                    Section(header: Text("Dados Cadastrais")) {
                        HStack {
                            Text("Nome")
                            Spacer()
                            TextField("Digite o nome", text: $fullName)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
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
                            TextField("Digite o seu celular", text: $phone)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Data de Nascimento")
                            Spacer()
                            TextField("Digite a sua data de nascimento", text: $birthday)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
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
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
