//
//  HomeViewModel.swift
//  Habit
//
//  Created by Adriano on 9/25/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let viewModel = HabitViewModel(intercator: HabitInteractor())
    let profileViewModel = ProfileViewModel()
    
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}
