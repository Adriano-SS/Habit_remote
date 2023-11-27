//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Adriano on 27/11/23.
//

import Foundation
import Combine

class ProfileInteractor{
    private let remote: ProfileRemoteDataSource = .shared
}

extension ProfileInteractor {
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fectchUser()
    }
    
    func updateUser(userId: Int, profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError> {
        return remote.updateUser(userId: userId, request: profileRequest)
    }
}
