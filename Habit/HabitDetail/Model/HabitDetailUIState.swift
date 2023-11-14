//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Adriano on 13/11/23.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
