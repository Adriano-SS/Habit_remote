//
//  SplashViewRouter.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI

enum SplashViewRouter {
    static func makeSignInView () -> some View {
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)	
    }
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    /*static func makeSignUpView() -> some View {
        let viewModel = SignUpViewModel()
        return SignUpView(viewModel: viewModel)
    }*/
}
