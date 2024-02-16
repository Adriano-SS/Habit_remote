//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Adriano on 22/11/23.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellableFetch: AnyCancellable?
    private var cancellableUpdate: AnyCancellable?
    
    private  let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableFetch?.cancel()
        cancellableUpdate?.cancel()
    }
    
    func fetchUser() {
        self.uiState = .loading
        
        cancellableFetch = interactor.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .fethcError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { ProfileResponse in
                self.userId = ProfileResponse.id
                self.email = ProfileResponse.email
                self.document = ProfileResponse.document
                self.gender = Gender.allCases[ProfileResponse.gender]
                self.fullNameValidation.value = ProfileResponse.fullname
                self.phoneValidation.value = ProfileResponse.phone
                self.birthdayValidation.value = ProfileResponse.birthday
                
                //Pega a String em formato americano e converte para Date
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                let dateFormatted  = formatter.date(from: ProfileResponse.birthday)
                
                //valida a data
                guard let dateFormatted = dateFormatted else {
                    self.uiState = .fethcError("Data inválida \(ProfileResponse.birthday)")
                    return
                }
                
                //converte para formato String brasileiro esperado pelo usuário
                formatter.dateFormat = "dd/MM/yyyy"
                let birthday = formatter.string(from: dateFormatted)
                
                self.birthdayValidation.value = birthday
                
                self.uiState = .fetchSuccess
            })
    }
    
    func updateUser() {
        self.uiState = .updateLoading
        
        guard let userId = userId, let gender = gender else { return}
        
        //Converte String do usuário para formato de data
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted  = formatter.date(from: birthdayValidation.value)
        
        //valida a entrada de usuario
        guard let dateFormatted = dateFormatted else {
            self.uiState = .updateError("Data inválida \(birthdayValidation.value)")
            return
        }
        
        //converte para formato String americano esperado pelo servidor
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        cancellableUpdate = interactor.updateUser(userId: userId, profileRequest: ProfileRequest(fullname: fullNameValidation.value, phone: phoneValidation.value, birthday: birthday, gender: gender.index))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .updateError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.uiState = .updateSuccess
            })
    }
    
}

class FullNameValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 4
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 14 || value.count > 15
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "" {
        didSet {
            failure = value.count != 10
        }
    }
}


