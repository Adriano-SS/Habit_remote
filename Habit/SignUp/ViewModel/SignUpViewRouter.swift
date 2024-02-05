//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Adriano on 9/27/23.
//

import SwiftUI
import Combine

class SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
