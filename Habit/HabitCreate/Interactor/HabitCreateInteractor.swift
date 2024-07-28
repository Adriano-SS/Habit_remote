//
//  HabitCreateInteractor.swift
//  Habit
//
//  Created by Adriano Soares on 28/07/24.
//

import Foundation
import Combine

class HabitCreateInteractor{
    private let remote: HabitCreateRemoteDataSource = .shared
}

//func
extension HabitCreateInteractor {
    func save(habitCreateRequest: HabitCreateRequest) -> Future<Void, AppError> {
        return remote.save(request: habitCreateRequest)
    }
}
