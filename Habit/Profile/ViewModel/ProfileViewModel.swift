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
    
    private var cancellable: AnyCancellable?
    private  let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fetchUser() {
        self.uiState = .loading
        
        cancellable = interactor.fetchUser()
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
            failure = value.count < 10 || value.count >= 12
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


