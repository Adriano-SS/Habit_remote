//
//  SignInUIState.swift
//  Habit
//
//  Created by Adriano on 9/25/23.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
