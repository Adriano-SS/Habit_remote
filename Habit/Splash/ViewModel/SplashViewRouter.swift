//
//  SplashViewRouter.swift
//  Habit
//
//  Created by Adriano on 9/20/23.
//

import SwiftUI

enum SplashViewRouter {
    static func makeSignInView () -> some View {
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)	
    }
    
    static func makeHomeView(viewModel: HomeViewModel) -> some View {
        //let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
}
