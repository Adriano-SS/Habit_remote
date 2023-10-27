//
//  SplashInteractor.swift
//  Habit
//
//  Created by Adriano on 27/10/23.
//

import Foundation
import Combine

class SplashInteractor{
    //private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    
    func fecthAuth() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
}
