//
//  SignUpViewModel.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUIState = .none
    
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var document: String = ""
    @Published var phone: String = ""
    @Published var birthday: String = ""
    @Published var gender: Gender = .male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    func signUp() {
        uiState = .loading
        
        //Converte String do usuário para formato de data
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted  = formatter.date(from: birthday)
        
        //valida a entrada de usuario
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        //converte para formato String americano esperado pelo servidor
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        WebService.postUser(request: SignUpRequest(fullname: fullName, email: email, document: document, phone: phone, gender: gender.index, birthday: birthday, password: password))
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //self.uiState = .error("Usuario ja existe!")
            //self.uiState = .sucess
            //self.publisher.send(true)
        //}
    }}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
