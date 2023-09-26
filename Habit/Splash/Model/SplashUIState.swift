//
//  SplashUIState.swift
//  Habit
//
//  Created by user246507 on 9/17/23.
//

import Foundation

enum SplashUIState{
    case loading
    case goToSignInScreen
    case goToSignUpScreen
    case goToHomeScreen
    case error(String)
}
