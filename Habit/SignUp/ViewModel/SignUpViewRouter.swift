//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by user246507 on 9/27/23.
//

import SwiftUI

class SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
