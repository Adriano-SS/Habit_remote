//
//  SignInViewRouter.swift
//  Habit
//
//  Created by Adriano on 9/25/23.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    static func makeHomeView () -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(intercator: SignUpInteractor())
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
    
}
