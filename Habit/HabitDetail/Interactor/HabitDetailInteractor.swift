//
//  Interactor.swift
//  Habit
//
//  Created by Adriano on 14/11/23.
//

import Foundation
import Combine

class HabitDetailInteractor{
    private let remote: HabitDetailRemoteDataSource = .shared
    
}

extension HabitDetailInteractor {
    func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppError> {
        return self.remote.save(habitId: habitId, request: request)
    }
}
