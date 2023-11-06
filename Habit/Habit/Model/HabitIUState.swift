//
//  HabitIUState.swift
//  Habit
//
//  Created by Adriano on 31/10/23.
//

import Foundation

enum HabitIUState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
