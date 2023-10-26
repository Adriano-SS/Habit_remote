//
//  SignInInteractor.swift
//  Habit
//
//  Created by Adriano on 23/10/23.
//

import Foundation
import Combine

class SignInInteractor{
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SignInInteractor {
    func login(loginRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return self.remote.login(request: request)
    }
    
    func insertUser(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
