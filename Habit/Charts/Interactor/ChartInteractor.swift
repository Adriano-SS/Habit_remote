//
//  ChartInteractor.swift
//  Habit
//
//  Created by Adriano on 07/12/23.
//

import Foundation
import Combine

class ChartInteractor{
    private let remote: ChartRemoteDataSource = .shared
}

extension ChartInteractor {
    
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        return remote.fectchHabitValues(habitId: habitId)
    }
}
