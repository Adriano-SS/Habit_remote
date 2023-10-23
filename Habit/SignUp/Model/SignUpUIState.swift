//
//  SignUpUIState.swift
//  Habit
//
//  Created by Adriano on 9/27/23.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
