//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Adriano on 22/11/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
}

class FullNameValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "Adriano Soares" {
        didSet {
            failure = value.count < 4
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "83999999999" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "29/01/1900" {
        didSet {
            failure = value.count != 10
        }
    }
}


