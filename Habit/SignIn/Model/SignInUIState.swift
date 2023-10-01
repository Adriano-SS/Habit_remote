//
//  SignInUIState.swift
//  Habit
//
//  Created by user246507 on 9/25/23.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
