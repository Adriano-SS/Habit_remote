//
//  SplashInteractor.swift
//  Habit
//
//  Created by Adriano on 27/10/23.
//

import Foundation
import Combine

class SplashInteractor{
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    
    func fecthAuth() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
    
    func insertUser(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }  
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return remote.refreshToken(request: request)
    }
}
