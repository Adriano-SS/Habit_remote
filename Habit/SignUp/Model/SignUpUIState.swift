//
//  SignUpUIState.swift
//  Habit
//
//  Created by user246507 on 9/27/23.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case sucess
    case error(String)
}
