//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Adriano on 9/27/23.
//

import SwiftUI

class SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    /*static func makeSingInView() -> some View {
        return SignInView(viewModel: SignInViewModel())
    }*/
}
