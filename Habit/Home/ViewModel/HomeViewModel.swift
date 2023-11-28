//
//  HomeViewModel.swift
//  Habit
//
//  Created by Adriano on 9/25/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let habitViewModel = HabitViewModel(isCharts: false, intercator: HabitInteractor())
    let habitForChartsViewModel = HabitViewModel(isCharts: true, intercator: HabitInteractor())
    let profileViewModel = ProfileViewModel(interactor: ProfileInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }
    
    func habitForChartView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitForChartsViewModel)
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}
