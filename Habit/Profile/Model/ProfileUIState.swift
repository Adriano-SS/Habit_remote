//
//  ProfileUIState.swift
//  Habit
//
//  Created by Adriano on 27/11/23.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fethcError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
