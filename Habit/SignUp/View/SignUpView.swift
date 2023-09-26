//
//  SignUpView.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var document: String = ""
    @State var phone: String = ""
    @State var birthday: String = ""
    @State var gender: Gender = .male
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color.black)
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
                }.padding(.horizontal, 8)
            }.padding()
        }        
    }
}

extension SignUpView {
    var fullNameField: some View {
        TextField("Nome completo", text: $fullName)
            .border(.black)
    }
}

extension SignUpView {
    var emailField: some View {
        TextField("E-mail", text: $email)
            .border(.black)
    }
}

extension SignUpView {
    var passwordField: some View {
        TextField("Password", text: $password)
            .border(.black)
    }
}

extension SignUpView {
    var documentField: some View {
        TextField("Document", text: $document)
            .border(.black)
    }
}

extension SignUpView {
    var phoneField: some View {
        TextField("Phone", text: $phone)
            .border(.black)
    }
}

extension SignUpView {
    var birthdayField: some View {
        TextField("Birthday", text: $birthday)
            .border(.black)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $gender) {
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
        Button("Realize seu cadastro") {
            
        }
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignUpViewModel()
        SignUpView(viewModel: viewModel)
    }
}
